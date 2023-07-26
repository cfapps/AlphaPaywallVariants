//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class AwardTableViewCellModel: QuickTableViewCellModelProtocol {
    
    var type: QuickTableViewCellProtocol.Type { AwardTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var title: String?
    
    var subTitle: String?
    
    var details: String?
    
    let insets: UIEdgeInsets
    
    var contentColor: UIColor
    
    var textColor: UIColor
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         title: String? = nil,
         subTitle: String? = nil,
         details: String? = nil,
         insets: UIEdgeInsets = .zero,
         contentColor: UIColor,
         textColor: UIColor) {
        self.id = id
        self.entity = entity
        self.title = title
        self.subTitle = subTitle
        self.details = details
        self.insets = insets
        self.contentColor = contentColor
        self.textColor = textColor
    }
}
