//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class QuestionTableViewCellModel: QuickTableViewCellModelProtocol {
    
    static var type: QuickTableViewCellProtocol.Type { QuestionTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var titleText: String?
    
    var descriptionText: String?
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         titleText: String?,
         descriptionText: String?) {
        self.id = id
        self.entity = entity
        self.titleText = titleText
        self.descriptionText = descriptionText
    }
}
