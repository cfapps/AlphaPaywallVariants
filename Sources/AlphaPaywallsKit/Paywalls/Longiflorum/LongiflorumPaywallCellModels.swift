//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class LongiflorumPaywallCellModels {
    
    enum SectionId: Int {
        
        case benefits
        case products
        case award
    }
    
    enum CellId: Int {
        
        case benefitsItems
        
        case productsItems
        
        case awardItem
    }
    
    // MARK: Section - Benefits
    
    lazy var benefitsSectionModel = QuickTableViewSection(
        id: SectionId.benefits.rawValue,
        header: benefitsHeaderModel,
        items: [benefitsItemsCellModel]
    )
    
    lazy var benefitsHeaderModel = AttributedTitleTableViewHeaderModel(
        text: NSAttributedString(),
        inset: UIEdgeInsets(top: 24, left: 32, bottom: 32, right: 32)
    )
    
    lazy var benefitsItemsCellModel = BenefitsTableViewCellModel(
        id: CellId.benefitsItems.rawValue,
        items: [],
        iconColor: UIColor.systemBlue,
        textColor: UIColor.label
    )
    
    // MARK: Section - Products
    
    lazy var productsSectionModel = QuickTableViewSection(
        id: SectionId.products.rawValue,
        items: [productsItemsCellModel]
    )
    
    lazy var productsItemsCellModel = ProductsTableViewCellModel(
        id: CellId.productsItems.rawValue,
        items: [],
        selectedItemId: nil,
        didSelectItem: nil,
        inset: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
        backgroundColor: UIColor.systemBackground,
        textColor: UIColor.systemBlue,
        selectedColor: UIColor.systemBlue,
        unselectedColor: UIColor.opaqueSeparator,
        checkmarkColor: UIColor.separator
    )
    
    // MARK: Section - Award
    
    lazy var awardSectionModel = QuickTableViewSection(
        id: SectionId.award.rawValue,
        items: [awardItemCellModel]
    )
    
    lazy var awardItemCellModel = AwardTableViewCellModel(
        id: CellId.awardItem.rawValue,
        title: nil,
        subTitle: nil,
        details: nil,
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
        contentColor: UIColor(red: 0, green: 0.48, blue: 1, alpha: 0.08),
        textColor: UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    )
    
    // MARK: Section - Features
    
    lazy var featuresSectionModel = QuickTableViewSection(
        header: featuresHeaderModel,
        items: [featuresCellModel]
    )
    
    lazy var featuresHeaderModel = TitleTableViewHeaderModel(
        titleText: nil,
        textColor: .black,
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
    )
    
    lazy var featuresCellModel = ObjectComparisonTableViewCellModel(
        items: [],
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
        contentColor: UIColor(red: 0, green: 0.48, blue: 1, alpha: 0.08),
        textColor: UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    )
}
