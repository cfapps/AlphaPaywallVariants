//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

extension UILabel {
    
    public static func calculateLabelHeight(_ text: String, _ font: UIFont) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = font
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label.systemLayoutSizeFitting(
            CGSize.zero,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel
        ).height
    }
}
