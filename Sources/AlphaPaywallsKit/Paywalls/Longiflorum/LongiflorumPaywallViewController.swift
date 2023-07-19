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
        return view
    }()
    
    override open var contentBackgroundColor: UIColor {
        UIColor.white
    }
    
    // MARK: Public properties
    
    open var titleText: NSAttributedString {
        NSAttributedString()
    }
    
    open var benefitItems: [BenefitItemViewModel] {
        []
    }
    
    open var productItems: [ProductItemViewModel] = []
    
    open var selectedProductId: String? = nil
    
    public convenience init() {
        self.init(style: .grouped)
    }
    
    public convenience init(
        products: [ProductItemViewModel],
        selectedProductId: String?) {
        self.init(style: .grouped)
        
        self.productItems = products
        self.selectedProductId = selectedProductId
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    open override func setupTableView() {
        super.setupTableView()
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
        
        tableView.register(headerFooterType: AttributedTitleTableViewHeaderModel.type)
        tableView.register(headerFooterType: TitleTableViewHeaderModel.type)
        
        tableView.register(cellType: FeaturesTableViewCellModel.type)
        tableView.register(cellType: AwardTableViewCellModel.type)
        tableView.register(cellType: ObjectComparisonTableViewCellModel.type)
        tableView.register(cellType: ReviewTableViewCellModel.type)
        tableView.register(cellType: QuestionTableViewCellModel.type)
        tableView.register(cellType: OptionsTableViewCellModel.type)
        
        tableView.configureEmptyHeaderView()
        tableView.configureEmptyFooterView()
        
        tableView.estimatedRowHeight = 263
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    open override func setupTableData() {
        cellModels.benefitsHeaderModel.text = titleText
        
        cellModels.benefitsItemsCellModel.items = benefitItems.map({
            FeaturesTableViewCellModel.Item(icon: $0.image, text: $0.text)
        })
        
        cellModels.productsItemsCellModel.items = productItems.map({
            return OptionsTableViewCellModel.Item(
                id: $0.id,
                titleText: $0.title,
                descriptionText: $0.description,
                detailsText: $0.details,
                badge: nil
            )
        })
        cellModels.productsItemsCellModel.selectedItemId = selectedProductId
        
        collection.update(with: [
            cellModels.benefitsSectionModel,
            cellModels.productsSectionModel,
            cellModels.awardSectionModel,
            cellModels.featuresSectionModel,
            cellModels.productsSectionModel
        ])
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bottomView.bringSubviewToFront(tableView)
    }
    
    private func setupUI() {
        view.addSubview(bottomView)
        
        bottomView.backgroundColor = .red
        bottomView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
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
}
