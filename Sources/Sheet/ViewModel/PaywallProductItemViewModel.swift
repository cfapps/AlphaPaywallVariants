//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import Foundation
import UIKit

public struct PaywallProductItemViewModel {
    
    public let id: String
    
    public let title: String
    
    public let description: String
    
    public let details: String
    
    public let actionText: String
    
    public let badge: Badge?
    
    public let steps: [Step]
    
    public let disclamer: String?
    
    public init(id: String, title: String, description: String, details: String, actionText: String, badge: Badge?, steps: [Step], disclamer: String?) {
        self.id = id
        self.title = title
        self.description = description
        self.details = details
        self.actionText = actionText
        self.badge = badge
        self.steps = steps
        self.disclamer = disclamer
    }
}

public extension PaywallProductItemViewModel {
    
    enum Badge {
        
        case text(String, color: UIColor, textColor: UIColor)
        case benefit(String, color: UIColor, textColor: UIColor)
    }
    
    struct Step {
        
        public let title: String
        
        public let subTitle: String
        
        public init(title: String, subTitle: String) {
            self.title = title
            self.subTitle = subTitle
        }
    }
}

extension PaywallProductItemViewModel.Badge {
    
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
