//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

extension LongiflorumPaywallViewController {
    
    public struct ContentItemViewModel {
        
        public let titleText: NSAttributedString
        
        public let benefits: BenefitsItemViewModel?
        
        public let products: ProductsItemViewModel?
        
        public let award: AwardItemViewModel?
        
        public let todos: TodosItemViewModel?
        
        public let helps: HelpSectionItemViewModel?
    }
}

// MARK: BenefitsItemViewModel

extension LongiflorumPaywallViewController {
    
    public struct BenefitsItemViewModel {
        
        public struct Item {
            
            let image: UIImage
            
            let text: String
            
            public init(image: UIImage, text: String) {
                self.image = image
                self.text = text
            }
        }
        
        public let items: [Item]
        
        public init(items: [Item]) {
            self.items = items
        }
    }
}

// MARK: ProductsItemViewModel

extension LongiflorumPaywallViewController {
    
    public struct ProductsItemViewModel {
        
        public struct Item {
            
            public let id: String
            
            public let title: String
            
            public let description: String
            
            public let details: String
            
            public let badge: BadgeItem?
            
            public init(id: String, title: String, description: String, details: String, badge: BadgeItem?) {
                self.id = id
                self.title = title
                self.description = description
                self.details = details
                self.badge = badge
            }
        }
        
        public struct BadgeItem {
            
            public let text: String
            
            public let color: UIColor
            
            public let textColor: UIColor
            
            public init(text: String, color: UIColor, textColor: UIColor) {
                self.text = text
                self.color = color
                self.textColor = textColor
            }
        }
        
        public let items: [Item]
        
        public let selectedItemId: String?
        
        public init(items: [Item], selectedItemId: String?) {
            self.items = items
            self.selectedItemId = selectedItemId
        }
    }
}

// MARK: AwardItemViewModel

extension LongiflorumPaywallViewController {
    
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
}

// MARK: TodoItemViewModel

extension LongiflorumPaywallViewController {
    
    public struct TodosItemViewModel {
        
        public struct Item {
            
            public let iconName: String
            
            public let titleText: String
            
            public let subTitleText: String
            
            public init(iconName: String, titleText: String, subTitleText: String) {
                self.iconName = iconName
                self.titleText = titleText
                self.subTitleText = subTitleText
            }
        }
        
        public let titleText: String
        
        public let items: [Item]
        
        public init(titleText: String, items: [Item]) {
            self.titleText = titleText
            self.items = items
        }
    }
}

// MARK: FeaturesItemViewModel

extension LongiflorumPaywallViewController {
    
    public struct FeaturesItemViewModel {
        
        public let titleText: String
        
        public let nameHeaderText: String
        
        public let noSubscriptionHeaderText: String
        
        public let withSubscriptionHeaderText: String
        
        public let items: [String]
        
        public init(titleText: String,
                    nameHeaderText: String,
                    noSubscriptionHeaderText: String,
                    withSubscriptionHeaderText: String,
                    items: [String]) {
            self.titleText = titleText
            self.nameHeaderText = nameHeaderText
            self.noSubscriptionHeaderText = noSubscriptionHeaderText
            self.withSubscriptionHeaderText = withSubscriptionHeaderText
            self.items = items
        }
    }
}

// MARK: HelpSectionItemViewModel

extension LongiflorumPaywallViewController {
    
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
}

// MARK: ReviewsItemViewModel

extension LongiflorumPaywallViewController {
    
    public struct ReviewsItemViewModel {
        
        public struct Item {
            
            public let name: String
            
            public let subject: String
            
            public let body: String
            
            public init(name: String, subject: String, body: String) {
                self.name = name
                self.subject = subject
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
}

// MARK: DisclamerItemViewModel

extension LongiflorumPaywallViewController {
    
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
