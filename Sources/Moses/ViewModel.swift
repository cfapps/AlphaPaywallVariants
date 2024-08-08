//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public final class PaywallViewModel {
    
    public let title: String
    
    public let subTitle: String
    
    public let headerAnimation: Data?
    
    public let termsOfServiceAction: String
    
    public let privacyPolicyAction: String
    
    public let restoreAction: String
    
    public let award: AwardItemViewModel?
    
    public let reviewsHeader: String?
    
    public let review: ReviewItemViewModel?
    
    public let featureHeader: String?
    
    public let feature: FeatureItemViewModel?
    
    public let helpHeader: String?
    
    public let help: HelpItemViewModel?
    
    public let benefit: BenefitItemViewModel?
    
    public let productHeader: String?
    
    public let product: ProductItemViewModel
    
    public init(title: String,
                subTitle: String,
                headerAnimation: Data?,
                termsOfServiceAction: String,
                privacyPolicyAction: String,
                restoreAction: String,
                award: AwardItemViewModel?,
                reviewsHeader: String?,
                review: ReviewItemViewModel,
                featureHeader: String?,
                feature: FeatureItemViewModel?,
                helpHeader: String?,
                help: HelpItemViewModel?,
                benefit: BenefitItemViewModel?,
                productHeader: String?,
                product: ProductItemViewModel) {
        self.title = title
        self.subTitle = subTitle
        self.headerAnimation = headerAnimation
        self.termsOfServiceAction = termsOfServiceAction
        self.privacyPolicyAction = privacyPolicyAction
        self.restoreAction = restoreAction
        self.award = award
        self.reviewsHeader = reviewsHeader
        self.review = review
        self.featureHeader = featureHeader
        self.feature = feature
        self.helpHeader = helpHeader
        self.help = help
        self.benefit = benefit
        self.productHeader = productHeader
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
        
        public let items: [Item]
        
        public init(items: [Item]) {
            self.items = items
        }
    }
}

extension PaywallViewModel.ReviewItemViewModel {
    
    public struct Item {
        
        public let image: UIImage?
        
        public let name: String
        
        public let text: String
        
        public init(image: UIImage?, name: String, text: String) {
            self.image = image
            self.name = name
            self.text = text
        }
    }
}

// MARK: Product

extension PaywallViewModel {
    
    public struct ProductItemViewModel {
        
        public let items: [Item]
        
        public let selectedItemId: String?
        
        public init(items: [Item], selectedItemId: String?) {
            self.items = items
            self.selectedItemId = selectedItemId
        }
    }
}

extension PaywallViewModel.ProductItemViewModel {
    
    public struct Item {
        
        public let id: String
        
        public let title: String
        
        public let price: String
        
        public let priceDetails: String
        
        public let priceDescription: String
        
        public let description: String
        
        public let badgeText: String?
        
        public let descriptionHeader: String?
        
        public let descriptionItems: [Description]?
        
        public let action: String
        
        public init(id: String,
                    title: String,
                    price: String,
                    priceDetails: String,
                    priceDescription: String,
                    description: String,
                    badgeText: String?,
                    descriptionHeader: String?,
                    descriptionItems: [Description]?,
                    action: String) {
            self.id = id
            self.title = title
            self.price = price
            self.priceDetails = priceDetails
            self.priceDescription = priceDescription
            self.description = description
            self.badgeText = badgeText
            self.descriptionHeader = descriptionHeader
            self.descriptionItems = descriptionItems
            self.action = action
        }
    }
    
    public struct Description {
        
        public let icon: UIImage?
        
        public let title: String
        
        public let subTitle: String
        
        public init(icon: UIImage?,
                    title: String,
                    subTitle: String) {
            self.icon = icon
            self.title = title
            self.subTitle = subTitle
        }
    }
}

// MARK: Feature

extension PaywallViewModel {
    
    public struct FeatureItemViewModel {
        
        public let title: String
        
        public let basic: String
        
        public let premium: String
        
        public let items: [Item]
        
        public init(title: String, basic: String, premium: String, items: [Item]) {
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
        
        public let items: [Item]
        
        public init(items: [Item]) {
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

// MARK: Benefit

extension PaywallViewModel {
    
    public struct BenefitItemViewModel {
        
        public let items: [Item]
        
        public init(items: [Item]) {
            self.items = items
        }
    }
}

extension PaywallViewModel.BenefitItemViewModel {
    
    public struct Item {
        
        public let icon: UIImage?
        
        public let title: String
        
        public init(icon: UIImage?, title: String) {
            self.icon = icon
            self.title = title
        }
    }
}
