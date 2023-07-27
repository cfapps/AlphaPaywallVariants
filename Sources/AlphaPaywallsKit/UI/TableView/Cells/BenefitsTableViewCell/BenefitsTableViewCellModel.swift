//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class BenefitsTableViewCellModel: QuickTableViewCellModelProtocol {
    
    struct Item {
        
        let icon: UIImage
        
        let title: String
    }
    
    var type: QuickTableViewCellProtocol.Type { BenefitsTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var items: [Item]
    
    var iconColor: UIColor
    
    var titleLabelColor: UIColor
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         items: [Item],
         iconColor: UIColor,
         titleLabelColor: UIColor) {
        self.id = id
        self.entity = entity
        self.items = items
        self.iconColor = iconColor
        self.titleLabelColor = titleLabelColor
    }
}

