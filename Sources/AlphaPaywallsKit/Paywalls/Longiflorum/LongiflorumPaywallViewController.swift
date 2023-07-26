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
        UIColor.white
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
//            cellModels.featuresCellModel.nameHeaderText = features.nameHeaderText
//            cellModels.featuresCellModel.noSubscriptionHeaderText = features.noSubscriptionHeaderText
//            cellModels.featuresCellModel.withSubscriptionHeaderText = features.withSubscriptionHeaderText
            cellModels.featuresCellModel.items = features.items
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
        
        tableView.register(headerFooterType: AttributedTitleTableViewHeaderModel.type)
        tableView.register(headerFooterType: TitleTableViewHeaderModel.type)
        
        tableView.register(cellType: BenefitsTableViewCellModel.type)
        tableView.register(cellType: AwardTableViewCellModel.type)
        tableView.register(cellType: ObjectComparisonTableViewCellModel.type)
        tableView.register(cellType: ReviewTableViewCellModel.type)
        tableView.register(cellType: QuestionTableViewCellModel.type)
        tableView.register(cellType: ProductsTableViewCellModel.type)
        
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
            self?.delegate?.didSelectProduct(withId: item.id)
        }
        
        cellModels.awardItemCellModel.contentColor = apperance.accentColor.withAlphaComponent(0.08)
        cellModels.awardItemCellModel.textColor = apperance.accentColor
        
        cellModels.featuresHeaderModel.textColor = apperance.primaryLabelColor
//        cellModels.featuresCellModel.contentColor = apperance.
//        cellModels.featuresCellModel.textColor = apperance.primaryLabelColor
        
        
        collection.update(with: [
            cellModels.benefitsSectionModel,
            cellModels.productsSectionModel,
            cellModels.awardSectionModel,
//            cellModels.featuresSectionModel,
//            cellModels.productsSectionModel
        ])
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomView.frame.height - view.safeAreaInsets.bottom, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    private func setupUI() {
        contentBackgroundColor = apperance.primaryBackgroundColor
        
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
        cellModels.productsItemsCellModel.isEnable = isEnable
        
        tableView.reloadData()
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
        case .benefits:
            return 40
        case .products:
            return 40
        case .award:
            return 40
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
        
        let titleText: String
        
        let nameHeaderText: String
        
        let noSubscriptionHeaderText: String
        
        let withSubscriptionHeaderText: String
        
        let items: [String]
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
