//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public protocol ColorAppearance {
    
    var systemBackground: UIColor { get }
    
    var secondarySystemBackground: UIColor { get }
    
    var label: UIColor { get }
    
    var secondaryLabel: UIColor { get }
    
    var tertiaryLabel: UIColor { get }
    
    var quaternaryLabel: UIColor { get }
    
    var separator: UIColor { get }
    
    // MARK: Additional
    
    var navigationBarTint: UIColor { get }
    
    var primaryButtonFill: UIColor { get }
    
    var primaryButtonLabel: UIColor { get }
    
    var secondaryButtonFill: UIColor { get }
    
    var secondaryButtonLabel: UIColor { get }
    
    var featureBasicBadgeFill: UIColor { get }
    
    var featurePremiumBadgeFill: UIColor { get }
}

final class DefaultColorAppearance: ColorAppearance {
    
    var systemBackground: UIColor {
        return UIColor.systemBackground
    }
    
    var secondarySystemBackground: UIColor {
        return UIColor.secondarySystemBackground
    }
    
    var label: UIColor {
        return UIColor.label
    }
    
    var secondaryLabel: UIColor { 
        return UIColor.secondaryLabel
    }
    
    var tertiaryLabel: UIColor { 
        return UIColor.tertiaryLabel
    }
    
    var quaternaryLabel: UIColor { 
        return UIColor.quaternaryLabel
    }
    
    var separator: UIColor {
        return UIColor.separator
    }
    
    var navigationBarTint: UIColor {
        return UIColor.systemBackground
    }
    
    var primaryButtonFill: UIColor {
        return UIColor.red
    }
    
    var primaryButtonLabel: UIColor {
        return UIColor.white
    }
    
    var secondaryButtonFill: UIColor {
        return UIColor.clear
    }
    
    var secondaryButtonLabel: UIColor {
        return UIColor.red
    }
    
    var featureBasicBadgeFill: UIColor {
        return UIColor.clear
    }
    
    var featurePremiumBadgeFill: UIColor {
        return UIColor.red
    }
}
