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
    
    public var apperance = ApperanceConfiguration.default
    
    public var titleText = NSAttributedString()
    
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
    
    public var benefitItems: [BenefitItemViewModel] = []
    
    public var productItems: [ProductItemViewModel] = []
    
    public var selectedProductId: String? = nil
    
    public var awardItem: AwardItemViewModel? {
        didSet {
            guard let awardItem = awardItem else {
                return
            }
            
            cellModels.awardItemCellModel.title = awardItem.title
            cellModels.awardItemCellModel.subTitle = awardItem.subTitle
            cellModels.awardItemCellModel.details = awardItem.details
        }
    }
    
    public var features: FeaturesItemViewModel? {
        didSet {
            guard let features = features else {
                return
            }
            
            cellModels.featuresHeaderModel.titleText = features.titleText
            cellModels.featuresCellModel.nameColumnHeader = features.nameHeaderText
            cellModels.featuresCellModel.aColumnHeader = features.noSubscriptionHeaderText
            cellModels.featuresCellModel.bColumnHeader = features.withSubscriptionHeaderText
            cellModels.featuresCellModel.items = features.items
        }
    }
    
    public var reviewSection: ReviewsItemViewModel? {
        didSet {
            cellModels.reviewsHeaderModel.titleText = reviewSection?.titleText
            
            var models: [ReviewTableViewCellModel] = []
            let itemsCount = (reviewSection?.items ?? []).count
            for (index, item) in (reviewSection?.items ?? []).enumerated() {
                models.append(cellModels.makeReviewCellModel(
                    item: item,
                    isFirst: index == 0,
                    isLast: index == itemsCount - 1,
                    apperance: apperance
                ))
            }
            
            cellModels.reviewsSectionModel.update(with: models)
        }
    }
    
    public var helpSection: HelpSectionItemViewModel? {
        didSet {
            cellModels.helpHeaderModel.titleText = helpSection?.title
            
            var models: [QuestionTableViewCellModel] = []
            let itemsCount = (helpSection?.items ?? []).count
            for (index, item) in (helpSection?.items ?? []).enumerated() {
                models.append(cellModels.makeHelpCellModel(
                    item: item,
                    separator: index != itemsCount - 1,
                    apperance: apperance
                ))
            }
            
            cellModels.helpSectionModel.update(with: models)
        }
    }
    
    public var disclamerSection: DisclamerItemViewModel? {
        didSet {
            if let disclamerSection = disclamerSection {
                cellModels.disclamerCellModel.iconName = disclamerSection.iconSystemName
                cellModels.disclamerCellModel.iconColor = disclamerSection.iconColor
                cellModels.disclamerCellModel.text = disclamerSection.text
                
                if let index = collection.index(sectionWithType: SectionId.disclamer) {
                    tableView.reloadSections([index], with: .none)
                }
            }
        }
    }
    
    public init() {
        super.init(style: .grouped)
    }
    
    public convenience init(
        products: [ProductItemViewModel],
        selectedProductId: String?) {
        self.init()
        
        self.productItems = products
        self.selectedProductId = selectedProductId
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
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.register(headerFooterType: AttributedTitleTableViewHeader.self)
        tableView.register(headerFooterType: TitleTableViewHeader.self)
        
        tableView.register(cellType: BenefitsTableViewCell.self)
        tableView.register(cellType: AwardTableViewCell.self)
        tableView.register(cellType: ObjectComparisonTableViewCell.self)
        tableView.register(cellType: ReviewTableViewCell.self)
        tableView.register(cellType: QuestionTableViewCell.self)
        tableView.register(cellType: ProductsTableViewCell.self)
        tableView.register(cellType: ToastTableViewCell.self)
        
        tableView.configureEmptyHeaderView()
        tableView.configureEmptyFooterView()
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    open override func setupTableData() {
        cellModels.benefitsHeaderModel.text = titleText
        
        cellModels.benefitsItemsCellModel.iconColor = apperance.accentColor
        cellModels.benefitsItemsCellModel.textColor = apperance.primaryLabelColor
        cellModels.benefitsItemsCellModel.items = benefitItems.map({
            BenefitsTableViewCellModel.Item(icon: $0.image, text: $0.text)
        })
        
        // Products
        cellModels.productsItemsCellModel.backgroundColor = apperance.primaryBackgroundColor
        cellModels.productsItemsCellModel.textColor = apperance.accentColor
        cellModels.productsItemsCellModel.selectedColor = apperance.accentColor
        cellModels.productsItemsCellModel.unselectedColor = apperance.separatorColor
        cellModels.productsItemsCellModel.checkmarkColor = apperance.quaternaryLabelColor
        cellModels.productsItemsCellModel.items = productItems.map({
            return ProductsTableViewCellModel.Item(
                id: $0.id,
                titleText: $0.title,
                descriptionText: $0.description,
                detailsText: $0.details,
                badge: nil
            )
        })
        cellModels.productsItemsCellModel.selectedItemId = selectedProductId
        cellModels.productsItemsCellModel.didSelectItem = { [weak self] (item) in
            self?.cellModels.productsCloneItemsCellModel.selectedItemId = item.id
            
            self?.delegate?.didSelectProduct(withId: item.id)
        }
        
        // Products clone
        cellModels.productsCloneItemsCellModel.backgroundColor = apperance.primaryBackgroundColor
        cellModels.productsCloneItemsCellModel.textColor = apperance.accentColor
        cellModels.productsCloneItemsCellModel.selectedColor = apperance.accentColor
        cellModels.productsCloneItemsCellModel.unselectedColor = apperance.separatorColor
        cellModels.productsCloneItemsCellModel.checkmarkColor = apperance.quaternaryLabelColor
        cellModels.productsCloneItemsCellModel.items = productItems.map({
            return ProductsTableViewCellModel.Item(
                id: $0.id,
                titleText: $0.title,
                descriptionText: $0.description,
                detailsText: $0.details,
                badge: nil
            )
        })
        cellModels.productsCloneItemsCellModel.selectedItemId = selectedProductId
        cellModels.productsCloneItemsCellModel.didSelectItem = { [weak self] (item) in
            self?.cellModels.productsItemsCellModel.selectedItemId = item.id
            
            self?.delegate?.didSelectProduct(withId: item.id)
        }
        
        // Award
        cellModels.awardItemCellModel.contentColor = apperance.accentColor.withAlphaComponent(0.08)
        cellModels.awardItemCellModel.textColor = apperance.accentColor
        
        // Features
        cellModels.featuresHeaderModel.textColor = apperance.primaryLabelColor
        cellModels.featuresCellModel.backgroundColor = apperance.accentColor.withAlphaComponent(0.08)
        cellModels.featuresCellModel.headerTextColor = apperance.accentColor
        cellModels.featuresCellModel.textColor = apperance.primaryLabelColor
        cellModels.featuresCellModel.positiveColor = apperance.accentColor
        cellModels.featuresCellModel.negativeColor = UIColor.systemRed
        
        // Reviews
        cellModels.reviewsHeaderModel.textColor = apperance.primaryLabelColor
        for item in cellModels.reviewsSectionModel.items {
            guard let item = item as? ReviewTableViewCellModel else {
                continue
            }
            
            item.backgroundColor = apperance.secondaryBackgroundColor
            item.titleColor = apperance.primaryLabelColor
            item.descriptionColor = apperance.secondaryLabelColor
            item.nameColor = apperance.tertiaryLabelColor
        }
        
        // Help
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
        
        // Disclamer
        cellModels.disclamerCellModel.textColor = apperance.primaryLabelColor
        
        var sectionModels: [QuickTableViewSection] = [
            cellModels.benefitsSectionModel,
            cellModels.productsSectionModel,
            cellModels.awardSectionModel,
            cellModels.featuresSectionModel,
            cellModels.reviewsSectionModel,
            cellModels.helpSectionModel,
            cellModels.productsCloneSectionModel
        ]
        
        if disclamerSection != nil {
            sectionModels.append(cellModels.disclamerCloneSectionModel)
        }
        
        collection.update(with: sectionModels)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomView.frame.height - view.safeAreaInsets.bottom, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    private func setupUI() {
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
    }
    
    @objc private func didTapContinueButton() {
        delegate?.didTapContinue()
    }
}

extension LongiflorumPaywallViewController {
    
    public func setContinueButton(text: String) {
        continueButton.title = text
    }
    
    public func setContinueButton(isIndicating: Bool) {
        if isIndicating {
            continueButton.startIndication()
        } else {
            continueButton.stopIndication()
        }
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
        case .benefits, .products, .award, .features, .reviews, .help:
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
}

extension LongiflorumPaywallViewController {
    
    public struct BenefitItemViewModel {
        
        let image: UIImage
        
        let text: String
        
        public init(image: UIImage, text: String) {
            self.image = image
            self.text = text
        }
    }
    
    public struct ProductItemViewModel {
        
        let id: String
        
        let title: String
        
        let description: String
        
        let details: String
        
        public init(id: String, title: String, description: String, details: String) {
            self.id = id
            self.title = title
            self.description = description
            self.details = details
        }
    }
    
    public struct AwardItemViewModel {
        
        public let title: String?
        
        public let subTitle: String?
        
        public let details: String?
        
        public init(title: String?, subTitle: String?, details: String?) {
            self.title = title
            self.subTitle = subTitle
            self.details = details
        }
    }
    
    public struct FeaturesItemViewModel {
        
        public let titleText: String
        
        public let nameHeaderText: String
        
        public let noSubscriptionHeaderText: String
        
        public let withSubscriptionHeaderText: String
        
        public let items: [String]
        
        public init(titleText: String, nameHeaderText: String, noSubscriptionHeaderText: String, withSubscriptionHeaderText: String, items: [String]) {
            self.titleText = titleText
            self.nameHeaderText = nameHeaderText
            self.noSubscriptionHeaderText = noSubscriptionHeaderText
            self.withSubscriptionHeaderText = withSubscriptionHeaderText
            self.items = items
        }
    }
    
    public struct ReviewsItemViewModel {
        
        public struct Item {
            
            public let name: String
            
            public let title: String
            
            public let body: String
            
            public init(name: String, title: String, body: String) {
                self.name = name
                self.title = title
                self.body = body
            }
        }
        
        public let titleText: String
        
        public let items: [Item]
        
        public init(titleText: String, items: [Item]) {
            self.titleText = titleText
            self.items = items
        }
    }
    
    public struct HelpSectionItemViewModel {
        
        public struct Item {
            
            public let question: String
            
            public let answer: String
            
            public init(question: String, answer: String) {
                self.question = question
                self.answer = answer
            }
        }
        
        public let title: String
        
        public let items: [Item]
        
        public init(title: String, items: [Item]) {
            self.title = title
            self.items = items
        }
    }
    
    public struct DisclamerItemViewModel {
        
        public let iconSystemName: String
        
        public let iconColor: UIColor
        
        public let text: String
        
        public init(iconSystemName: String, iconColor: UIColor, text: String) {
            self.iconSystemName = iconSystemName
            self.iconColor = iconColor
            self.text = text
        }
    }
}

extension LongiflorumPaywallViewController {
    
    public struct ApperanceConfiguration {
        
        public let accentColor: UIColor
        
        public let accentLabelColor: UIColor
        
        public let primaryLabelColor: UIColor
        
        public let secondaryLabelColor: UIColor
        
        /// Color of checkmark in product cell
        public let quaternaryLabelColor: UIColor
        
        public let tertiaryLabelColor: UIColor
        
        public let invertPrimaryLabelColor: UIColor
        
        public let separatorColor: UIColor
        
        public let primaryBackgroundColor: UIColor
        
        public let secondaryBackgroundColor: UIColor
        
        static var `default`: ApperanceConfiguration {
            ApperanceConfiguration(
                accentColor: UIColor.systemBlue,
                accentLabelColor: UIColor.white,
                primaryLabelColor: UIColor.black,
                secondaryLabelColor: UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.6),
                quaternaryLabelColor: UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.18),
                tertiaryLabelColor: UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.3),
                invertPrimaryLabelColor: UIColor.white,
                separatorColor: UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.12),
                primaryBackgroundColor: UIColor.white,
                secondaryBackgroundColor: UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
            )
        }
        
        public init(accentColor: UIColor,
                    accentLabelColor: UIColor,
                    primaryLabelColor: UIColor,
                    secondaryLabelColor: UIColor,
                    quaternaryLabelColor: UIColor,
                    tertiaryLabelColor: UIColor,
                    invertPrimaryLabelColor: UIColor,
                    separatorColor: UIColor,
                    primaryBackgroundColor: UIColor,
                    secondaryBackgroundColor: UIColor) {
            self.accentColor = accentColor
            self.accentLabelColor = accentLabelColor
            self.primaryLabelColor = primaryLabelColor
            self.secondaryLabelColor = secondaryLabelColor
            self.quaternaryLabelColor = quaternaryLabelColor
            self.tertiaryLabelColor = tertiaryLabelColor
            self.invertPrimaryLabelColor = invertPrimaryLabelColor
            self.separatorColor = separatorColor
            self.primaryBackgroundColor = primaryBackgroundColor
            self.secondaryBackgroundColor = secondaryBackgroundColor
        }
    }
}
