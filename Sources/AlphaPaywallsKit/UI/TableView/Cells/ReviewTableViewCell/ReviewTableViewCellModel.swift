//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import QuickTableKit

final class ReviewTableViewCellModel: QuickTableViewCellModelProtocol {
    
    static var type: QuickTableViewCellProtocol.Type { ReviewTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var title: String
    
    var description: String
    
    var name: String
    
    var topInset: CGFloat
    
    var bottomInset: CGFloat
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         title: String,
         description: String,
         name: String,
         topInset: CGFloat = 0,
         bottomInset: CGFloat = 0) {
        self.id = id
        self.entity = entity
        self.title = title
        self.description = description
        self.name = name
        self.topInset = topInset
        self.bottomInset = bottomInset
    }
}
