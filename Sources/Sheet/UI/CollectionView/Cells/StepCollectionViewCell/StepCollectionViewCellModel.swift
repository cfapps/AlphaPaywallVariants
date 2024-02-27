//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import Foundation
import QuickToolKit

final class StepCollectionViewCellModel: QuickCollectionViewCellModelProtocol {
    
    var type: QuickCollectionViewCellProtocol.Type { StepCollectionViewCell.self }
    
    var id: Int?
    
    var entity: StringIdentifiable?
    
    var iconImageName: String
    
    var titleText: String
    
    var subTitleText: String
    
    init(id: Int? = nil,
         entity: StringIdentifiable? = nil,
         iconImageName: String,
         titleText: String,
         subTitleText: String) {
        self.id = id
        self.entity = entity
        self.iconImageName = iconImageName
        self.titleText = titleText
        self.subTitleText = subTitleText
    }
}
