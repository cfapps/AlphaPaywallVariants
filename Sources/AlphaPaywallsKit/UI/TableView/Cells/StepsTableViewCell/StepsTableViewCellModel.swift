//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class StepsTableViewCellModel: QuickTableViewCellModelProtocol {
    
    struct Item {
        
        let iconImage: UIImage
        
        let titleText: String
        
        let subTitleText: String
    }
    
    var type: QuickTableViewCellProtocol.Type { StepsTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var items: [Item]
    
    var titleLabelColor: UIColor
    
    var subTitleLabelColor: UIColor
    
    let insets: UIEdgeInsets
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         items: [Item],
         titleLabelColor: UIColor,
         subTitleLabelColor: UIColor,
         insets: UIEdgeInsets = .zero) {
        self.id = id
        self.entity = entity
        self.items = items
        self.titleLabelColor = titleLabelColor
        self.subTitleLabelColor = subTitleLabelColor
        self.insets = insets
    }
}
