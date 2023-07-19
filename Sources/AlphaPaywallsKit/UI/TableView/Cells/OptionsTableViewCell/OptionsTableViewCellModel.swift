//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class OptionsTableViewCellModel: QuickTableViewCellModelProtocol {
    
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
    
    static var type: QuickTableViewCellProtocol.Type { OptionsTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var items: [Item]
    
    var selectedItemId: String?
    
    let didSelectItem: ((Item) -> Void)?
    
    let inset: UIEdgeInsets
    
    let backgroundColor: UIColor
    
    let unselectedColor: UIColor
    
    let selectedColor: UIColor
    
    let labelColor: UIColor
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         items: [Item],
         selectedItemId: String?,
         didSelectItem: ((Item) -> Void)? = nil,
         inset: UIEdgeInsets,
         backgroundColor: UIColor,
         unselectedColor: UIColor,
         selectedColor: UIColor,
         labelColor: UIColor) {
        self.id = id
        self.entity = entity
        self.items = items
        self.selectedItemId = selectedItemId
        self.didSelectItem = didSelectItem
        self.inset = inset
        self.backgroundColor = backgroundColor
        self.unselectedColor = unselectedColor
        self.selectedColor = selectedColor
        self.labelColor = labelColor
    }
}
