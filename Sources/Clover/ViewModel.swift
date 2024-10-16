//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public final class PaywallViewModel {
    
    public let title: String
    
    public let termsOfServiceAction: String
    
    public let privacyPolicyAction: String
    
    public let restoreAction: String
    
    public let productsAction: String
    
    public let options: [String]
    
    public let benefits: [String]
    
    public let detailsText: String
    
    public let subDetailsText: String
    
    public let award: AwardItemViewModel
    
    public let review: ReviewItemViewModel
    
    public let feature: FeatureItemViewModel
    
    public let help: HelpItemViewModel
    
    public let product: ProductItemViewModel
    
    public init(title: String,
                termsOfServiceAction: String,
                privacyPolicyAction: String,
                restoreAction: String,
                productsAction: String,
                options: [String],
                benefits: [String],
                detailsText: String,
                subDetailsText: String,
                award: AwardItemViewModel,
                review: ReviewItemViewModel,
                feature: FeatureItemViewModel,
                help: HelpItemViewModel,
                product: ProductItemViewModel) {
        self.title = title
        self.termsOfServiceAction = termsOfServiceAction
        self.privacyPolicyAction = privacyPolicyAction
        self.restoreAction = restoreAction
        self.productsAction = productsAction
        self.options = options
        self.benefits = benefits
        self.detailsText = detailsText
        self.subDetailsText = subDetailsText
        self.award = award
        self.review = review
        self.feature = feature
        self.help = help
        self.product = product
    }
}

// MARK: Award

extension PaywallViewModel {
    
    public struct AwardItemViewModel {
        
        public let title: String
        
        public let icon: UIImage?
        
        public init(title: String, icon: UIImage?) {
            self.title = title
            self.icon = icon
        }
    }
}

// MARK: Review

extension PaywallViewModel {
    
    public struct ReviewItemViewModel {
        
        public let header: String
        
        public let items: [Item]
        
        public init(header: String, items: [Item]) {
            self.header = header
            self.items = items
        }
    }
}

extension PaywallViewModel.ReviewItemViewModel {
    
    public struct Item {
        
        public let text: String
        
        public init(text: String) {
            self.text = text
        }
    }
}

// MARK: Product

extension PaywallViewModel {
    
    public struct ProductItemViewModel {
        
        public let items: [Item]
        
        public let defaultItemId: String?
        
        public init(items: [Item], defaultItemId: String?) {
            self.items = items
            self.defaultItemId = defaultItemId
        }
    }
}

extension PaywallViewModel.ProductItemViewModel {
    
    public struct Item {
        
        public let id: String
        
        public let titleText: String
        
        public let subTitleText: String
        
        public let detailsText: String
        
        public let subDetailsText: String
        
        public let descriptionText: String
        
        public let subDescriptionText: String
        
        public let badgeText: String
        
        public let actionText: String
        
        public let extendActionText: String
        
        public init(id: String, titleText: String, subTitleText: String, detailsText: String, subDetailsText: String, descriptionText: String, subDescriptionText: String, badgeText: String, actionText: String, extendActionText: String) {
            self.id = id
            self.titleText = titleText
            self.subTitleText = subTitleText
            self.detailsText = detailsText
            self.subDetailsText = subDetailsText
            self.descriptionText = descriptionText
            self.subDescriptionText = subDescriptionText
            self.badgeText = badgeText
            self.actionText = actionText
            self.extendActionText = extendActionText
        }
    }
}

// MARK: Feature

extension PaywallViewModel {
    
    public struct FeatureItemViewModel {
        
        public let header: String
        
        public let title: String
        
        public let basic: String
        
        public let premium: String
        
        public let items: [Item]
        
        public init(header: String, title: String, basic: String, premium: String, items: [Item]) {
            self.header = header
            self.title = title
            self.basic = basic
            self.premium = premium
            self.items = items
        }
    }
}

extension PaywallViewModel.FeatureItemViewModel {
    
    public struct Item {
        
        public let text: String
        
        public let isAvailableBasic: Bool
        
        public let isAvailablePremium: Bool
        
        public init(text: String, isAvailableBasic: Bool, isAvailablePremium: Bool) {
            self.text = text
            self.isAvailableBasic = isAvailableBasic
            self.isAvailablePremium = isAvailablePremium
        }
    }
}

// MARK: Help

extension PaywallViewModel {
    
    public struct HelpItemViewModel {
        
        public let header: String
        
        public let items: [Item]
        
        public init(header: String, items: [Item]) {
            self.header = header
            self.items = items
        }
    }
}

extension PaywallViewModel.HelpItemViewModel {
    
    public struct Item {
        
        public let title: String
        
        public let description: String
        
        public init(title: String, subTitle: String) {
            self.title = title
            self.description = subTitle
        }
    }
}
