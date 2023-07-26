//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

class ProductsTableViewCellModel: QuickTableViewCellModelProtocol {
    
    struct Item {
        
        let id: String
        
        let titleText: String?
        
        let descriptionText: String?
        
        let detailsText: String?
        
        let badge: Badge?
    }
    
    struct Badge {
        
        let text: String
        
        let color: UIColor
        
        let textColor: UIColor
    }
    
    var type: QuickTableViewCellProtocol.Type { ProductsTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var items: [Item]
    
    var selectedItemId: String?
    
    var didSelectItem: ((Item) -> Void)?
    
    let inset: UIEdgeInsets
    
    var backgroundColor: UIColor
    
    var textColor: UIColor
    
    var selectedColor: UIColor
    
    var unselectedColor: UIColor
    
    var checkmarkColor: UIColor
    
    var isEnable: Bool
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         items: [Item],
         selectedItemId: String?,
         didSelectItem: ((Item) -> Void)? = nil,
         inset: UIEdgeInsets,
         backgroundColor: UIColor,
         textColor: UIColor,
         selectedColor: UIColor,
         unselectedColor: UIColor,
         checkmarkColor: UIColor,
         isEnable: Bool = true) {
        self.id = id
        self.entity = entity
        self.items = items
        self.selectedItemId = selectedItemId
        self.didSelectItem = didSelectItem
        self.inset = inset
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        self.checkmarkColor = checkmarkColor
        self.isEnable = isEnable
    }
}
