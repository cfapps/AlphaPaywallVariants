//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public final class PaywallViewModel {
    
    public let termsOfServiceAction: String
    
    public let privacyPolicyAction: String
    
    public let restoreAction: String
    
    public let award: AwardItemViewModel
    
    public let reviewsHeader: String
    
    public let reviews: [ReviewItemViewModel]
    
    public let feature: FeatureItemViewModel
    
    public let help: HelpItemViewModel
    
    public let products: [ProductItemViewModel]
    
    public init(termsOfServiceAction: String,
                privacyPolicyAction: String,
                restoreAction: String,
                award: AwardItemViewModel,
                reviewsHeader: String,
                reviews: [ReviewItemViewModel],
                feature: FeatureItemViewModel,
                help: HelpItemViewModel,
                products: [ProductItemViewModel]) {
        self.termsOfServiceAction = termsOfServiceAction
        self.privacyPolicyAction = privacyPolicyAction
        self.restoreAction = restoreAction
        self.award = award
        self.reviewsHeader = reviewsHeader
        self.reviews = reviews
        self.feature = feature
        self.help = help
        self.products = products
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

// MARK: Product

extension PaywallViewModel {
    
    public struct ProductItemViewModel {
        
        public let id: String
        
        public let title: String
        
        public let subTitle: String
        
        public let detailsTitle: String
        
        public let detailsSubTitle: String
        
        public let price: String
        
        public let priceDuration: String
        
        public let priceSubTitle: String
        
        public let priceDescription: String
        
        public let options: [Option]
        
        public let connectActionText: String
        
        public init(id: String,
                    title: String,
                    subTitle: String,
                    detailsTitle: String,
                    detailsSubTitle: String,
                    price: String,
                    priceDuration: String,
                    priceSubTitle: String,
                    priceDescription: String,
                    options: [Option],
                    connectActionText: String) {
            self.id = id
            self.title = title
            self.subTitle = subTitle
            self.detailsTitle = detailsTitle
            self.detailsSubTitle = detailsSubTitle
            self.price = price
            self.priceDuration = priceDuration
            self.priceSubTitle = priceSubTitle
            self.priceDescription = priceDescription
            self.options = options
            self.connectActionText = connectActionText
        }
    }
}

extension PaywallViewModel.ProductItemViewModel {
    
    public struct Option {
        
        public let image: UIImage?
        
        public let text: String
        
        public init(image: UIImage?, text: String) {
            self.image = image
            self.text = text
        }
    }
}

// MARK: Review

extension PaywallViewModel {
    
    public struct ReviewItemViewModel {
        
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
