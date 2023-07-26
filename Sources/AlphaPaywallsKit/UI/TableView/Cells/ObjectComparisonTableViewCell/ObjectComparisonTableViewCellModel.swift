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
    
    var nameColumnHeader: String
    
    var aColumnHeader: String
    
    var bColumnHeader: String
    
    var items: [String]
    
    var backgroundColor: UIColor
    
    var headerTextColor: UIColor
    
    var textColor: UIColor
    
    var positiveColor: UIColor
    
    var negativeColor: UIColor
    
    var insets: UIEdgeInsets
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         nameColumnHeader: String,
         aColumnHeader: String,
         bColumnHeader: String,
         items: [String],
         backgroundColor: UIColor,
         headerTextColor: UIColor,
         textColor: UIColor,
         positiveColor: UIColor,
         negativeColor: UIColor,
         insets: UIEdgeInsets) {
        self.id = id
        self.entity = entity
        self.nameColumnHeader = nameColumnHeader
        self.aColumnHeader = aColumnHeader
        self.bColumnHeader = bColumnHeader
        self.items = items
        self.backgroundColor = backgroundColor
        self.headerTextColor = headerTextColor
        self.textColor = textColor
        self.positiveColor = positiveColor
        self.negativeColor = negativeColor
        self.insets = insets
    }
}
