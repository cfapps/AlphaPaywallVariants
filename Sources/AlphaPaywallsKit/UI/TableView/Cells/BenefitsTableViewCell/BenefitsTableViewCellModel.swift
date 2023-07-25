//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class BenefitsTableViewCellModel: QuickTableViewCellModelProtocol {
    
    struct Item {
        
        let icon: UIImage
        
        let text: String
    }
    
    static var type: QuickTableViewCellProtocol.Type { BenefitsTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var items: [Item]
    
    var iconColor: UIColor
    
    var textColor: UIColor
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         items: [Item],
         iconColor: UIColor,
         textColor: UIColor) {
        self.id = id
        self.entity = entity
        self.items = items
        self.iconColor = iconColor
        self.textColor = textColor
    }
}

