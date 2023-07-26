//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class AttributedTitleTableViewHeaderModel: QuickTableViewHeaderFooterModelProtocol {
    
    var type: QuickTableViewHeaderFooterViewProtocol.Type { AttributedTitleTableViewHeader.self }
    
    var text: NSAttributedString
    
    var inset: UIEdgeInsets
    
    init(text: NSAttributedString,
         inset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 32, bottom: 32, right: 32)) {
        self.text = text
        self.inset = inset
    }
}
