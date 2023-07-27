//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class ObjectComparisonTableViewCellModel: QuickTableViewCellModelProtocol {
    
    struct Item {
        
        let text: String
        
        let hasOptionOne: Bool
        
        let hasOptionTwo: Bool
    }
    
    var type: QuickTableViewCellProtocol.Type { ObjectComparisonTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var headerNameText: String
    
    var headerOptionOneText: String
    
    var headerOptionTwoText: String
    
    var items: [Item]
    
    var contentBackgroundColor: UIColor
    
    var headerLabelColor: UIColor
    
    var itemLabelColor: UIColor
    
    var checkedColor: UIColor
    
    var uncheckedColor: UIColor
    
    var insets: UIEdgeInsets
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         headerNameText: String,
         headerOptionOneText: String,
         headerOptionTwoText: String,
         items: [Item],
         contentBackgroundColor: UIColor,
         headerLabelColor: UIColor,
         itemLabelColor: UIColor,
         checkedColor: UIColor,
         uncheckedColor: UIColor,
         insets: UIEdgeInsets) {
        self.id = id
        self.entity = entity
        self.headerNameText = headerNameText
        self.headerOptionOneText = headerOptionOneText
        self.headerOptionTwoText = headerOptionTwoText
        self.items = items
        self.contentBackgroundColor = contentBackgroundColor
        self.headerLabelColor = headerLabelColor
        self.itemLabelColor = itemLabelColor
        self.checkedColor = checkedColor
        self.uncheckedColor = uncheckedColor
        self.insets = insets
    }
}
