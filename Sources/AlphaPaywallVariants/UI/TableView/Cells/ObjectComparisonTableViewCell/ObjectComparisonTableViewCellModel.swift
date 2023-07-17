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
    
    var contentColor: UIColor
    
    var textColor: UIColor
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         items: [String],
         contentColor: UIColor,
         textColor: UIColor) {
        self.id = id
        self.entity = entity
        self.items = items
        self.contentColor = contentColor
        self.textColor = textColor
    }
}
