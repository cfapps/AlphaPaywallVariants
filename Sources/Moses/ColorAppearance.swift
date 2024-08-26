//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public protocol ColorAppearance {
    
    var systemBackground: UIColor { get }
    
    var secondarySystemBackground: UIColor { get }
    
    var tertiarySystemBackground: UIColor { get }
    
    var label: UIColor { get }
    
    var secondaryLabel: UIColor { get }
    
    var tertiaryLabel: UIColor { get }
    
    var quaternaryLabel: UIColor { get }
    
    var accentLabel: UIColor { get }
    
    var separator: UIColor { get }
    
    // MARK: Additional
    
    var accent: UIColor { get }
    
    var navigationBarTint: UIColor { get }
    
    var titleLabel: UIColor { get }
    
    var primaryButtonFill: UIColor { get }
    
    var primaryButtonLabel: UIColor { get }
    
    var featureHeaderLabel: UIColor { get }
    
    var featureBasicHeaderFill: UIColor { get }
    
    var featureBasicHeaderLabel: UIColor { get }
    
    var featurePremiumHeaderFill: UIColor { get }
    
    var featurePremiumHeaderLabel: UIColor { get }
}
