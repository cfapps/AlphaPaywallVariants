//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickToolKit

final class QuestionTableViewCellModel: QuickTableViewCellModelProtocol {
    
    var type: QuickTableViewCellProtocol.Type { QuestionTableViewCell.self }
    
    var id: Int?
    
    var entity: (any QuickIdentifiable)?
    
    var titleText: String?
    
    var descriptionText: String?
    
    var expand: Bool
    
    init(id: Int? = nil,
         entity: (any QuickIdentifiable)? = nil,
         titleText: String?,
         descriptionText: String?,
         expand: Bool = false) {
        self.id = id
        self.entity = entity
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.expand = expand
    }
}
