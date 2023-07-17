//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class TitleTableViewHeaderModel: QuickTableViewHeaderModelProtocol {
    
    var titleText: String?
    
    var textColor: UIColor
    
    init(titleText: String?,
         textColor: UIColor) {
        self.titleText = titleText
        self.textColor = textColor
    }
    
    func getType() -> QuickTableViewHeaderProtocol.Type {
        return TitleTableViewHeader.self
    }
}
