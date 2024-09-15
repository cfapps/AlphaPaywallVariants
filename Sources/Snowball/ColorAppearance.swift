//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public protocol ColorAppearance {
    
    // MARK: Backgrounds
    
    var systemBackground: UIColor { get }
    
    var secondarySystemBackground: UIColor { get }
    
    var tertiarySystemBackground: UIColor { get }
    
    // MARK: Backgrounds
    
    var label: UIColor { get }
    
    var secondaryLabel: UIColor { get }
    
    var tertiaryLabel: UIColor { get }
    
    var quaternaryLabel: UIColor { get }
    
    var accentLabel: UIColor { get }
    
    var invertPrimaryLabel: UIColor { get }
    
    // MARK: Additional
    
    var accent: UIColor { get }
    
    var navigationBarTint: UIColor { get }
    
    var separator: UIColor { get }
}
