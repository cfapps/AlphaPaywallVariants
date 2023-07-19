//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class ObjectComparisonTableViewCellModel: QuickTableViewCellModelProtocol {
    
    static var type: QuickTableViewCellProtocol.Type { ObjectComparisonTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var items: [String]
    
    var insets: UIEdgeInsets
    
    var contentColor: UIColor
    
    var textColor: UIColor
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         items: [String],
         insets: UIEdgeInsets,
         contentColor: UIColor,
         textColor: UIColor) {
        self.id = id
        self.entity = entity
        self.items = items
        self.insets = insets
        self.contentColor = contentColor
        self.textColor = textColor
    }
}
