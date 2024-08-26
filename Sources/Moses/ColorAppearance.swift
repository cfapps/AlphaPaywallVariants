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
    
    var featureBasicBadgeFill: UIColor { get }
    
    var featureBasicBadgeLabel: UIColor { get }
    
    var featurePremiumBadgeFill: UIColor { get }
    
    var featurePremiumBadgeLabel: UIColor { get }
}
