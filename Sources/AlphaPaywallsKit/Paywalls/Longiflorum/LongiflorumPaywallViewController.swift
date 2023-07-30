//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

open class LongiflorumPaywallViewController: QuickExtendTableViewController {
    
    private typealias SectionId = LongiflorumPaywallCellModels.SectionId
    private typealias CellId = LongiflorumPaywallCellModels.CellId
    
    private let cellModels = LongiflorumPaywallCellModels()
    
    private var headerHeightCache: [Int: CGFloat] = [:]
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = apperance.primaryBackgroundColor
        return view
    }()
    
    private lazy var bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = apperance.separatorColor
        return view
    }()
    
    override open var contentBackgroundColor: UIColor {
        apperance.primaryBackgroundColor
    }
    
    private lazy var continueButton: IncidactionButton = {
        let button = IncidactionButton()
        button.setBackgroundColor(color: apperance.accentColor, forState: .normal)
        button.setBackgroundColor(color: apperance.accentColor.withAlphaComponent(0.7), forState: .disabled)
        button.setBackgroundColor(color: apperance.accentColor.withAlphaComponent(0.7), forState: .highlighted)
        button.indicationColor = apperance.accentLabelColor
        button.setTitleColor(apperance.accentLabelColor, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var termsOfServiceButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitleColor(apperance.secondaryLabelColor, for: .normal)
        button.setTitleColor(apperance.secondaryLabelColor.withAlphaComponent(0.7), for: .disabled)
        button.setTitleColor(apperance.secondaryLabelColor.withAlphaComponent(0.7), for: .highlighted)
        button.contentEdgeInsets = UIEdgeInsets(top: 9, left: 8, bottom: 9, right: 8)
        button.addAction { [unowned self] in
            self.delegate?.didTapTermsOfService()
        }
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitleColor(apperance.secondaryLabelColor, for: .normal)
        button.setTitleColor(apperance.secondaryLabelColor.withAlphaComponent(0.7), for: .disabled)
        button.setTitleColor(apperance.secondaryLabelColor.withAlphaComponent(0.7), for: .highlighted)
        button.contentEdgeInsets = UIEdgeInsets(top: 9, left: 8, bottom: 9, right: 8)
        button.addAction { [unowned self] in
            self.delegate?.didTapPrivacyPolicy()
        }
        return button
    }()
    
    private lazy var bottomButtonsContainer = UIView()
    
    private lazy var bottomButtonsBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = apperance.separatorColor
        return view
    }()
    
    // MARK: Public properties
    
    weak open var delegate: LongiflorumPaywallDelegate?
    
    weak open var dataSource: LongiflorumPaywallDataSource?
    
    public var apperance = ApperanceConfiguration.default
    
    public var termsOfServiceButtonText: String? {
        didSet {
            termsOfServiceButton.setTitle(termsOfServiceButtonText, for: .normal)
        }
    }
    
    public var privacyPolicyButtonText: String? {
        didSet {
            privacyPolicyButton.setTitle(privacyPolicyButtonText, for: .normal)
        }
    }
    
    public init() {
        super.init(style: .grouped)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    open override func setupTableView() {
        super.setupTableView()
        
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(headerFooterType: AttributedTitleTableViewHeader.self)
        tableView.register(headerFooterType: TitleTableViewHeader.self)
        
        tableView.register(cellType: BenefitsTableViewCell.self)
        tableView.register(cellType: AwardTableViewCell.self)
        tableView.register(cellType: ObjectComparisonTableViewCell.self)
        tableView.register(cellType: ReviewsTableViewCell.self)
        tableView.register(cellType: QuestionTableViewCell.self)
        tableView.register(cellType: ProductsTableViewCell.self)
        tableView.register(cellType: ToastTableViewCell.self)
        tableView.register(cellType: StepsTableViewCell.self)
        
        tableView.configureEmptyHeaderView()
        tableView.configureEmptyFooterView()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    open override func setupTableData() {
        guard let dataSource = dataSource else {
            fatalError("Field dataSource not set")
        }
        
        var selectedProductId: String?
        
        cellModels.benefitsHeaderModel.text = dataSource.getTitle()
        
        do {
            let benefit = dataSource.getBenefitSection()
            cellModels.benefitsItemsCellModel.items = benefit.items.map {
                return BenefitsTableViewCellModel.Item(icon: $0.image, title: $0.text)
            }
        }
        collection.add(section: cellModels.benefitsSectionModel)
        
        do {
            let product = dataSource.getProductSection()
            selectedProductId = product.selectedItemId
            
            let productItems = product.items.map {
                ProductsTableViewCellModel.Item(
                    id: $0.id,
                    titleText: $0.title,
                    descriptionText: $0.description,
                    detailsText: $0.details,
                    badge: $0.badge.flatMap {
                        ProductsTableViewCellModel.Badge(
                            text: $0.text,
                            color: $0.color,
                            textColor: $0.textColor
                        )
                    }
                )
            }
            
            cellModels.productsItemsCellModel.items = productItems
            cellModels.productsItemsCellModel.selectedItemId = selectedProductId
            cellModels.productsItemsCellModel.didSelectItem = { [weak self] (item) in
                guard let self = self else { return }
                
                self.cellModels.productsCloneItemsCellModel.selectedItemId = item.id
                self.didChangeSelectedProduct(item.id)
            }
            
            cellModels.productsCloneItemsCellModel.items = productItems
            cellModels.productsCloneItemsCellModel.selectedItemId = selectedProductId
            cellModels.productsCloneItemsCellModel.didSelectItem = { [weak self] (item) in
                guard let self = self else { return }
                
                self.cellModels.productsItemsCellModel.selectedItemId = item.id
                self.didChangeSelectedProduct(item.id)
            }
        }
        
        collection.add(section: cellModels.productsSectionModel)
        
        if let item = dataSource.getAwardSection() {
            cellModels.awardItemCellModel.title = item.title
            cellModels.awardItemCellModel.subTitle = item.subTitle
            cellModels.awardItemCellModel.details = item.details
            
//            collection.add(section: cellModels.awardSectionModel)
        }
        
        if let productId = selectedProductId, let item = dataSource.getTodoSection(forProduct: productId) {
            cellModels.todoHeaderModel.titleText = item.titleText
            cellModels.todoItemCellModel.items = item.items.map {
                StepsTableViewCellModel.Item(
                    iconImage: UIImage(systemName: $0.iconName)!,
                    titleText: $0.titleText,
                    subTitleText: $0.subTitleText
                )
            }
            
            collection.add(section: cellModels.todoSectionModel)
        }
        
        if let item = dataSource.getFeatureSection() {
            cellModels.featuresHeaderModel.titleText = item.titleText
            cellModels.featuresCellModel.headerNameText = item.nameHeaderText
            cellModels.featuresCellModel.headerOptionOneText = item.noSubscriptionHeaderText
            cellModels.featuresCellModel.headerOptionTwoText = item.withSubscriptionHeaderText
            cellModels.featuresCellModel.items = item.items.map {
                return ObjectComparisonTableViewCellModel.Item(
                    text: $0,
                    hasOptionOne: false,
                    hasOptionTwo: true
                )
            }
            
            collection.add(section: cellModels.featuresSectionModel)
        }
        
        if let item = dataSource.getReviewSection() {
            cellModels.reviewsHeaderModel.titleText = item.titleText
            cellModels.reviewItemCellModel.items = item.items.map {
                .init(name: $0.name, subject: $0.subject, body: $0.body)
            }
            
            collection.add(section: cellModels.reviewsSectionModel)
        }
        
        if let help = dataSource.getHelpSection() {
            cellModels.helpHeaderModel.titleText = help.title
            cellModels.helpSectionModel.update(with: [])
            for (index, item) in help.items.enumerated() {
                cellModels.helpSectionModel.add(
                    item: cellModels.makeHelpCellModel(
                        item: item,
                        separator: index < help.items.count - 1,
                        apperance: apperance
                    )
                )
            }
            
            collection.add(section: cellModels.helpSectionModel)
        }
        
        collection.add(section: cellModels.productsCloneSectionModel)
        
        if let productId = selectedProductId, let disclamer = dataSource.getDisclamerSection(forProduct: productId) {
            cellModels.disclamerCellModel.iconName = disclamer.iconSystemName
            cellModels.disclamerCellModel.text = disclamer.text
            cellModels.disclamerCellModel.iconColor = disclamer.iconColor
            cellModels.disclamerCellModel.textColor = apperance.primaryLabelColor
            
            collection.add(section: cellModels.disclamerCloneSectionModel)
        }
        
        if let productId = selectedProductId {
            continueButton.title = dataSource.getContinueButtonText(forProduct: productId)
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomView.frame.height - view.safeAreaInsets.bottom, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    private func setupUI() {
        configureApperance()
        
        bottomButtonsContainer.addSubview(termsOfServiceButton)
        bottomButtonsContainer.addSubview(privacyPolicyButton)
        bottomButtonsContainer.addSubview(bottomButtonsBorderView)
        
        bottomView.addSubview(continueButton)
        bottomView.addSubview(bottomButtonsContainer)
        bottomView.addSubview(bottomBorderView)
        
        view.addSubview(bottomView)
        
        termsOfServiceButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(bottomButtonsContainer.snp.centerX)
        }
        
        privacyPolicyButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(bottomButtonsContainer.snp.centerX)
            make.right.equalToSuperview()
        }
        
        bottomButtonsBorderView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview().inset(9)
            make.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        bottomButtonsContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(continueButton.snp.bottom).offset(8)
            make.bottom.equalTo(bottomView.safeAreaLayoutGuide.snp.bottom)
        }
        
        bottomBorderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        tableView.performBatchUpdates { }
    }
    
    @objc private func didTapContinueButton() {
        delegate?.didTapContinue()
    }
    
    private func configureApperance() {
        cellModels.benefitsItemsCellModel.iconColor = apperance.accentColor
        cellModels.benefitsItemsCellModel.titleLabelColor = apperance.primaryLabelColor
        
        cellModels.productsItemsCellModel.backgroundColor = apperance.primaryBackgroundColor
        cellModels.productsItemsCellModel.textColor = apperance.accentColor
        cellModels.productsItemsCellModel.selectedColor = apperance.accentColor
        cellModels.productsItemsCellModel.unselectedColor = apperance.separatorColor
        cellModels.productsItemsCellModel.checkmarkColor = apperance.quaternaryLabelColor
        
        cellModels.productsCloneItemsCellModel.backgroundColor = apperance.primaryBackgroundColor
        cellModels.productsCloneItemsCellModel.textColor = apperance.accentColor
        cellModels.productsCloneItemsCellModel.selectedColor = apperance.accentColor
        cellModels.productsCloneItemsCellModel.unselectedColor = apperance.separatorColor
        cellModels.productsCloneItemsCellModel.checkmarkColor = apperance.quaternaryLabelColor
        
        cellModels.awardItemCellModel.contentColor = apperance.accentColor.withAlphaComponent(0.08)
        cellModels.awardItemCellModel.textColor = apperance.accentColor
        
        cellModels.todoItemCellModel.titleLabelColor = apperance.primaryLabelColor
        cellModels.todoItemCellModel.subTitleLabelColor = apperance.secondaryLabelColor
        
        cellModels.featuresHeaderModel.textColor = apperance.primaryLabelColor
        cellModels.featuresCellModel.contentBackgroundColor = apperance.accentColor.withAlphaComponent(0.08)
        cellModels.featuresCellModel.headerLabelColor = apperance.accentColor
        cellModels.featuresCellModel.itemLabelColor = apperance.primaryLabelColor
        cellModels.featuresCellModel.checkedColor = apperance.accentColor
        cellModels.featuresCellModel.uncheckedColor = UIColor.systemRed
        
        cellModels.reviewsHeaderModel.textColor = apperance.primaryLabelColor
        cellModels.reviewItemCellModel.contentBackgroundColor = apperance.secondaryBackgroundColor
        cellModels.reviewItemCellModel.nameLabelColor = apperance.tertiaryLabelColor
        cellModels.reviewItemCellModel.subjectLabelColor = apperance.primaryLabelColor
        cellModels.reviewItemCellModel.bodyLabelColor = apperance.secondaryLabelColor
        
        cellModels.helpHeaderModel.textColor = apperance.primaryLabelColor
        for item in cellModels.helpSectionModel.items {
            guard let item = item as? QuestionTableViewCellModel else {
                continue
            }
            
            item.primaryLabelColor = apperance.primaryLabelColor
            item.secondaryLabelColor = apperance.secondaryLabelColor
            item.collapsedChevronColor = apperance.tertiaryLabelColor
            item.expandedChevronColor = apperance.secondaryLabelColor
            item.separatorColor = apperance.separatorColor
        }
        
        cellModels.disclamerCellModel.textColor = apperance.primaryLabelColor
    }
    
    private func didChangeSelectedProduct(_ id: String) {
        var neddUpdateTableView: Bool = false
        
        if let todoSection = dataSource?.getTodoSection(forProduct: id) {
            cellModels.todoHeaderModel.titleText = todoSection.titleText
            cellModels.todoItemCellModel.items = todoSection.items.map {
                return StepsTableViewCellModel.Item(
                    iconImage: UIImage(systemName: $0.iconName)!,
                    titleText: $0.titleText,
                    subTitleText: $0.subTitleText
                )
            }
            
            if collection.index(sectionWithType: SectionId.todo) != nil {
                neddUpdateTableView = true
            } else if let index = collection.index(sectionWithType: SectionId.products) {
                collection.add(section: cellModels.todoSectionModel, at: index + 1)
                neddUpdateTableView = true
            }
        } else {
            if let index = collection.index(sectionWithType: SectionId.todo) {
                collection.remove(sectionAt: index)
                neddUpdateTableView = true
            }
        }
        
        if let disclamer = dataSource?.getDisclamerSection(forProduct: id) {
            cellModels.disclamerCellModel.text = disclamer.text
            cellModels.disclamerCellModel.iconName = disclamer.iconSystemName
            cellModels.disclamerCellModel.iconColor = disclamer.iconColor
            
            if collection.index(sectionWithType: SectionId.disclamer) != nil {
                neddUpdateTableView = true
            } else {
                let index = collection.sections.count
                collection.add(section: cellModels.disclamerCloneSectionModel, at: index)
                neddUpdateTableView = true
            }
        } else if let index = collection.index(sectionWithType: SectionId.disclamer) {
            collection.remove(sectionAt: index)
            neddUpdateTableView = true
        }
        
        if neddUpdateTableView {
            tableView.reloadData()
        }
        
        continueButton.title = dataSource?.getContinueButtonText(forProduct: id)
        
        delegate?.didSelectProduct(withId: id)
    }
}

extension LongiflorumPaywallViewController {
    
    public func setContinueButton(isIndicating: Bool) {
        if isIndicating {
            continueButton.startIndication()
        } else {
            continueButton.stopIndication()
        }
    }
    
    public func setContinueButton(isEnabled: Bool) {
        continueButton.isEnabled = isEnabled
    }
    
    public func setContent(isEnable: Bool) {
        if isEnable {
            collection.enableCells(in: tableView)
        } else {
            collection.disableCells(in: tableView)
        }
    }
    
    public func setDisclamer(isHidden: Bool) {
        func hideSection() {
            guard let index = collection.index(sectionWithType: SectionId.disclamer) else {
                return
            }
            
            collection.remove(sectionAt: index)
            UIView.performWithoutAnimation {
                tableView.deleteSections([index], with: .none)
            }
        }
        
        func showSection() {
            guard collection.index(sectionWithType: SectionId.disclamer) == nil else {
                return
            }
            
            let index = collection.sections.count
            collection.add(section: cellModels.disclamerCloneSectionModel, at: index)
            UIView.performWithoutAnimation {
                tableView.insertSections([index], with: .none)
            }
        }
        
        if isHidden {
            hideSection()
        } else {
            showSection()
        }
    }
}

extension LongiflorumPaywallViewController {
    
    open func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        guard let cellId: CellId = collection.identifier(for: indexPath) else {
            return nil
        }
        
        switch cellId {
        case .helpItem:
            return indexPath
        default:
            return nil
        }
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return headerHeightCache[section] ?? UITableView.automaticDimension
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return collection.hasHeader(at: section) ? UITableView.automaticDimension : 0
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard collection.hasHeader(at: section) else {
            return nil
        }
        
        return tableViewDataSource.dequeue(tableView, viewForHeaderInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let sectionId: SectionId = collection.sectionId(at: section) else {
            return collection.hasFooter(at: section) ? UITableView.automaticDimension : 0
        }
        
        switch sectionId {
        case .benefits, .products, .award, .features, .reviews, .help, .todo:
            return 40
        case .productsClone:
            return 16
        case .disclamer:
            return 32
        default:
            return collection.hasFooter(at: section) ? UITableView.automaticDimension : 0
        }
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard collection.hasFooter(at: section) else {
            return nil
        }
        
        return tableViewDataSource.dequeue(tableView, viewForFooterInSection: section)
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellId: CellId = collection.identifier(for: indexPath) else {
            return
        }
        
        switch cellId {
        case .helpItem:
            guard let cell = tableView.cellForRow(at: indexPath) as? QuestionTableViewCell else { return }
            tableView.performBatchUpdates {
                cell.toggle()
            }
        default:
            break
        }
    }
    
    open func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        headerHeightCache[section] = view.frame.size.height
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let originalOffset = view.safeAreaInsets.top + scrollView.contentOffset.y
        
        if let headerView = tableView.headerView(forSection: 0), originalOffset <= headerView.frame.height - 32 {
            navigationItem.title = nil
        } else {
            navigationItem.title = dataSource?.getTitle()
        }
    }
}
