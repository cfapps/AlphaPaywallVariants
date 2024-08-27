//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public protocol ColorAppearance {
    
    // MARK: Backgrounds
    
    var systemBackground: UIColor { get }
    
    var secondarySystemBackground: UIColor { get }
    
    var primaryButtonBackground: UIColor { get }
    
    // MARK: Labels
    
    var label: UIColor { get }
    
    var secondaryLabel: UIColor { get }
    
    var tertiaryLabel: UIColor { get }
    
    var primaryButtonLabel: UIColor { get }
    
    // MARK: Other
    
    var separator: UIColor { get }
    
    var navigationBarTint: UIColor { get }
    
    var featurePremiumBadgeFill: UIColor { get }
}
