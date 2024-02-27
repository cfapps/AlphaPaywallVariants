//
// Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func calculateSize(_ text: String,
                              font: UIFont,
                              width: CGFloat = CGFloat.greatestFiniteMagnitude,
                              height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        let label = UILabel()
        label.font = font
        label.text = text
        return label.sizeThatFits(CGSize(width: width, height: height))
    }
}
