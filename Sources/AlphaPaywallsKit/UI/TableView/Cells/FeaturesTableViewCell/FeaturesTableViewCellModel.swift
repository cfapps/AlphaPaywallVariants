//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class FeaturesTableViewCellModel: QuickTableViewCellModelProtocol {
    
    struct Item {
        
        let icon: UIImage
        
        let text: String
    }
    
    static var type: QuickTableViewCellProtocol.Type { FeaturesTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var items: [Item]
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         items: [Item]) {
        self.id = id
        self.entity = entity
        self.items = items
    }
}

