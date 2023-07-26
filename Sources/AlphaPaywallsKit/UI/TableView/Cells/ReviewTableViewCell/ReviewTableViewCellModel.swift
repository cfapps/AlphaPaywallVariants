//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class ReviewTableViewCellModel: QuickTableViewCellModelProtocol {
    
    var type: QuickTableViewCellProtocol.Type { ReviewTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var title: String
    
    var description: String
    
    var name: String
    
    var backgroundColor: UIColor
    
    var titleColor: UIColor
    
    var descriptionColor: UIColor
    
    var nameColor: UIColor
    
    var insets: UIEdgeInsets
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         title: String,
         description: String,
         name: String,
         backgroundColor: UIColor,
         titleColor: UIColor,
         descriptionColor: UIColor,
         nameColor: UIColor,
         insets: UIEdgeInsets = UIEdgeInsets.zero) {
        self.id = id
        self.entity = entity
        self.title = title
        self.description = description
        self.name = name
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
        self.nameColor = nameColor
        self.insets = insets
    }
}
