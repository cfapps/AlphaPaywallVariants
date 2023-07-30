//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func findLastParent<T: UIViewController>() -> T? {
        guard let parentViewController = parent?.findLastParent() as? T else {
            return self as? T
        }
        
        return parentViewController
    }
    
    func findLastParentNavigationController() -> UINavigationController? {
        findLastParent()
    }
}
