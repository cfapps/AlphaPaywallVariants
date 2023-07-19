//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class FeatureCollectionViewCellModel: QuickCollectionViewCellModelProtocol {
    
    static var type: QuickCollectionViewCellProtocol.Type { FeatureCollectionViewCell.self }
    
    var id: Int?
    
    var entity: QuickTableKit.IdentifiableEntity?
    
    var icon: UIImage
    
    var text: String
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         icon: UIImage,
         text: String) {
        self.id = id
        self.entity = entity
        self.icon = icon
        self.text = text
    }
}
