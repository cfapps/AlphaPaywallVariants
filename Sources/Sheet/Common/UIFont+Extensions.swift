//
// Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

internal extension UIFont {
    
    static func preferredFont(forTextStyle style: UIFont.TextStyle, weight: UIFont.Weight) -> UIFont {
        UIFont.preferredFont(forTextStyle: style).with(weight: weight)
    }
    
    private func with(weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: pointSize, weight: weight)
    }
}
