//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class ToastTableViewCellModel: QuickTableViewCellModelProtocol {
    
    var type: QuickTableViewCellProtocol.Type { ToastTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var iconName: String
    
    var text: String
    
    var iconColor: UIColor
    
    var textColor: UIColor
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         iconName: String,
         text: String,
         iconColor: UIColor,
         textColor: UIColor) {
        self.id = id
        self.entity = entity
        self.iconName = iconName
        self.text = text
        self.iconColor = iconColor
        self.textColor = textColor
    }
}
