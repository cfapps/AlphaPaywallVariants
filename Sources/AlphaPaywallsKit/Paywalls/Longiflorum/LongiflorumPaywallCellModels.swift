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
        case todo
        case features
        case reviews
        case help
        case productsClone
        case disclamer
    }
    
    enum CellId: Int {
        
        case benefitsItems
        
        case productsItems
        
        case awardItem
        
        case todo
        
        case featureItem
        
        case reviewItem
        
        case helpItem
        
        case productsCloneItem
        
        case disclamer
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
        titleLabelColor: UIColor.label
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
    
    // MARK: Section - Steps
    
    lazy var todoSectionModel = QuickTableViewSection(
        id: SectionId.todo.rawValue,
        header: todoHeaderModel,
        items: [todoItemCellModel]
    )
    
    lazy var todoHeaderModel = TitleTableViewHeaderModel(
        textColor: .black,
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    )
    
    lazy var todoItemCellModel = StepsTableViewCellModel(
        id: CellId.todo.rawValue,
        items: [],
        titleLabelColor: UIColor.label,
        subTitleLabelColor: UIColor.secondaryLabel,
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    )
    
    // MARK: Section - Features
    
    lazy var featuresSectionModel = QuickTableViewSection(
        id: SectionId.features.rawValue,
        header: featuresHeaderModel,
        items: [featuresCellModel]
    )
    
    lazy var featuresHeaderModel = TitleTableViewHeaderModel(
        titleText: nil,
        textColor: .black,
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    )
    
    lazy var featuresCellModel = ObjectComparisonTableViewCellModel(
        id: CellId.featureItem.rawValue,
        headerNameText: "",
        headerOptionOneText: "",
        headerOptionTwoText: "",
        items: [],
        contentBackgroundColor: UIColor.secondarySystemBackground,
        headerLabelColor: UIColor.label,
        itemLabelColor: UIColor.label,
        checkedColor: UIColor.green,
        uncheckedColor: UIColor.red,
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    )
    
    // MARK: Section - Reviews
    
    lazy var reviewsSectionModel = QuickTableViewSection(
        id: SectionId.reviews.rawValue,
        header: reviewsHeaderModel,
        items: [reviewItemCellModel]
    )
    
    lazy var reviewItemCellModel = ReviewsTableViewCellModel(
        id: CellId.reviewItem.rawValue,
        items: [],
        contentBackgroundColor: UIColor.tertiarySystemBackground,
        nameLabelColor: UIColor.label,
        subjectLabelColor: UIColor.secondaryLabel,
        bodyLabelColor: UIColor.quaternaryLabel,
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    )
    
    lazy var reviewsHeaderModel = TitleTableViewHeaderModel(
        titleText: nil,
        textColor: .black,
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    )
    
    // MARK: Section - Help
    
    lazy var helpSectionModel = QuickTableViewSection(
        id: SectionId.help.rawValue,
        header: helpHeaderModel,
        items: []
    )
    
    lazy var helpHeaderModel = TitleTableViewHeaderModel(
        titleText: nil,
        textColor: .black,
        insets: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    )
    
    func makeHelpCellModel(item: LongiflorumPaywallViewController.HelpSectionItemViewModel.Item,
                           separator: Bool,
                           apperance: LongiflorumPaywallViewController.ApperanceConfiguration) -> QuestionTableViewCellModel {
        return QuestionTableViewCellModel(
            id: CellId.helpItem.rawValue,
            titleText: item.question,
            descriptionText: item.answer,
            showSeparator: separator,
            primaryLabelColor: apperance.primaryLabelColor,
            secondaryLabelColor: apperance.secondaryLabelColor,
            collapsedChevronColor: apperance.tertiaryLabelColor,
            expandedChevronColor: apperance.secondaryLabelColor,
            separatorColor: apperance.separatorColor,
            insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        )
    }
    
    // MARK: Section - Products Clone
    
    lazy var productsCloneSectionModel = QuickTableViewSection(
        id: SectionId.productsClone.rawValue,
        items: [productsCloneItemsCellModel]
    )
    
    lazy var productsCloneItemsCellModel = ProductsTableViewCellModel(
        id: CellId.productsCloneItem.rawValue,
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
    
    // MARK: Section - Disclamer
    
    lazy var disclamerCloneSectionModel = QuickTableViewSection(
        id: SectionId.disclamer.rawValue,
        items: [disclamerCellModel]
    )
    
    lazy var disclamerCellModel = ToastTableViewCellModel(
        id: CellId.disclamer.rawValue,
        iconName: "checkmark.shield.fill",
        text: "asdad asdad",
        iconColor: .systemGreen,
        textColor: .orange
    )
}
