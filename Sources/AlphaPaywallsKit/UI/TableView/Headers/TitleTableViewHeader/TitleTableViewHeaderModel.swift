//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class TitleTableViewHeaderModel: QuickTableViewHeaderFooterModelProtocol {
    
    static var type: QuickTableViewHeaderFooterViewProtocol.Type { TitleTableViewHeader.self }
    
    var titleText: String?
    
    var textColor: UIColor
    
    var insets: UIEdgeInsets
    
    init(titleText: String?,
         textColor: UIColor,
         insets: UIEdgeInsets = .zero) {
        self.titleText = titleText
        self.textColor = textColor
        self.insets = insets
    }
}
