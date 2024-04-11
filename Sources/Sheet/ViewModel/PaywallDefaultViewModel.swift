//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import UIKit

public struct PaywallDefaultViewModel: PaywallViewModel {
    
    public let title: String
    
    public let products: ProductViewModel
    
    public let benefits: BenefitViewModel
    
    public let questions: QuestionViewModel
    
    public let reviews: ReviewViewModel
    
    public let feature: FeatureViewModel
    
    public let termsOfServiceText: String?
    
    public let privacyPolicyText: String?
    
    public init(title: String,
                products: ProductViewModel,
                benefits: BenefitViewModel,
                questions: QuestionViewModel,
                reviews: ReviewViewModel,
                feature: FeatureViewModel,
                termsOfServiceText: String?,
                privacyPolicyText: String?) {
        self.title = title
        self.products = products
        self.benefits = benefits
        self.questions = questions
        self.reviews = reviews
        self.feature = feature
        self.termsOfServiceText = termsOfServiceText
        self.privacyPolicyText = privacyPolicyText
    }
}

extension PaywallDefaultViewModel {
    
    public struct BenefitViewModel {
        
        public enum ItemIcon: String {
            
            case clients
            case documents
            case reminders
            case reports
            case restrictions
        }
        
        public struct Item {
            
            public let icon: ItemIcon
            
            public let titleText: String
            
            public init(icon: ItemIcon, titleText: String) {
                self.icon = icon
                self.titleText = titleText
            }
        }
        
        public let items: [Item]
        
        public init(items: [Item]) {
            self.items = items
        }
    }
    
    public struct QuestionViewModel {
        
        public let title: String
        
        public let items: [Item]
        
        public init(title: String, items: [Item]) {
            self.title = title
            self.items = items
        }
        
        public struct Item {
            
            public let questionText: String
            
            public let answerText: String
            
            public init(questionText: String, answerText: String) {
                self.questionText = questionText
                self.answerText = answerText
            }
        }
    }
    
    public struct ProductViewModel {
        
        public let items: [Item]
        
        public let selectedItemId: String?
        
        public init(items: [Item], selectedItemId: String?) {
            self.items = items
            self.selectedItemId = selectedItemId
        }
        
        public struct Item {
            
            public enum Badge {
                
                case text(String, color: UIColor, textColor: UIColor)
                case benefit(String, color: UIColor, textColor: UIColor)
            }
            
            public struct Step {
                
                public let title: String
                
                public let subTitle: String
                
                public init(title: String, subTitle: String) {
                    self.title = title
                    self.subTitle = subTitle
                }
            }
            
            public let id: String
            
            public let title: String
            
            public let description: String
            
            public let details: String
            
            public let actionText: String
            
            public let badge: Badge?
            
            public let stepsText: String?
            
            public let steps: [Step]
            
            public let disclamer: String?
            
            public init(id: String, title: String, description: String, details: String, actionText: String, badge: Badge?, stepsText: String?, steps: [Step], disclamer: String?) {
                self.id = id
                self.title = title
                self.description = description
                self.details = details
                self.actionText = actionText
                self.badge = badge
                self.stepsText = stepsText
                self.steps = steps
                self.disclamer = disclamer
            }
        }
    }
    
    public struct ReviewViewModel {
        
        public let title: String
        
        public let items: [Item]
        
        public init(title: String, items: [Item]) {
            self.title = title
            self.items = items
        }
        
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
    }
    
    public struct FeatureViewModel {
        
        public let title: String
        
        public let name: String
        
        public let positive: String
        
        public let negative: String
        
        public let items: [Item]
        
        public init(title: String, name: String, positive: String, negative: String, items: [Item]) {
            self.title = title
            self.name = name
            self.positive = positive
            self.negative = negative
            self.items = items
        }
        
        public struct Item {
            
            public let name: String
            
            public init(name: String) {
                self.name = name
            }
        }
    }
}

extension PaywallDefaultViewModel.ProductViewModel.Item.Badge {
    
    var text: String {
        switch self {
        case .text(let text, _, _):
            return text
        case .benefit(let text, _, _):
            return text
        }
    }
    
    var color: UIColor {
        switch self {
        case .text(_, let color, _):
            return color
        case .benefit(_, let color, _):
            return color
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .text(_, _, let color):
            return color
        case .benefit(_, _, let color):
            return color
        }
    }
}
