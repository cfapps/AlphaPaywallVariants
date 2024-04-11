//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickToolKit

final class FeatureCollectionViewCellModel: QuickCollectionViewCellModelProtocol {
    
    var type: QuickCollectionViewCellProtocol.Type { FeatureCollectionViewCell.self }
    
    var id: Int?
    
    var entity: (any QuickIdentifiable)?
    
    var iconImageName: String
    
    var text: String
    
    init(id: Int? = nil,
         entity: (any QuickIdentifiable)? = nil,
         iconImageName: String,
         text: String) {
        self.id = id
        self.entity = entity
        self.iconImageName = iconImageName
        self.text = text
    }
}
