//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import Foundation
import QuickToolKit

final class ReviewCollectionViewCellModel: QuickCollectionViewCellModelProtocol {
    
    var type: QuickCollectionViewCellProtocol.Type { ReviewCollectionViewCell.self }
    
    var id: Int?
    
    var entity: (any QuickIdentifiable)?
    
    var name: String
    
    var subject: String
    
    var body: String
    
    init(id: Int? = nil,
         entity: (any QuickIdentifiable)? = nil,
         name: String,
         subject: String,
         body: String) {
        self.id = id
        self.entity = entity
        self.name = name
        self.subject = subject
        self.body = body
    }
}
