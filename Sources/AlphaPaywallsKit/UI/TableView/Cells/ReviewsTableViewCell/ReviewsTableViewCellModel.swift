//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class ReviewsTableViewCellModel: QuickTableViewCellModelProtocol {
    
    struct Item {
        
        let name: String
        
        let subject: String
        
        let body: String
    }
    
    var type: QuickTableViewCellProtocol.Type { ReviewsTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var items: [Item]
    
    var contentBackgroundColor: UIColor
    
    var nameLabelColor: UIColor
    
    var subjectLabelColor: UIColor
    
    var bodyLabelColor: UIColor
    
    var insets: UIEdgeInsets
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         items: [Item],
         contentBackgroundColor: UIColor,
         nameLabelColor: UIColor,
         subjectLabelColor: UIColor,
         bodyLabelColor: UIColor,
         insets: UIEdgeInsets = UIEdgeInsets.zero) {
        self.id = id
        self.entity = entity
        self.items = items
        self.contentBackgroundColor = contentBackgroundColor
        self.nameLabelColor = nameLabelColor
        self.subjectLabelColor = subjectLabelColor
        self.bodyLabelColor = bodyLabelColor
        self.insets = insets
    }
}
