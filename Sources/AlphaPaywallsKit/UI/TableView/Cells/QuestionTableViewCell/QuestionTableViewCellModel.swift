//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class QuestionTableViewCellModel: QuickTableViewCellModelProtocol {
    
    var type: QuickTableViewCellProtocol.Type { QuestionTableViewCell.self }
    
    var id: Int?
    
    var entity: IdentifiableEntity?
    
    var titleText: String?
    
    var descriptionText: String?
    
    var expand: Bool
    
    var showSeparator: Bool
    
    var primaryLabelColor: UIColor
    
    var secondaryLabelColor: UIColor
    
    var collapsedChevronColor: UIColor
    
    var expandedChevronColor: UIColor
    
    var separatorColor: UIColor
    
    let insets: UIEdgeInsets
    
    init(id: Int? = nil,
         entity: IdentifiableEntity? = nil,
         titleText: String?,
         descriptionText: String?,
         expand: Bool = false,
         showSeparator: Bool,
         primaryLabelColor: UIColor,
         secondaryLabelColor: UIColor,
         collapsedChevronColor: UIColor,
         expandedChevronColor: UIColor,
         separatorColor: UIColor,
         insets: UIEdgeInsets) {
        self.id = id
        self.entity = entity
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.expand = expand
        self.showSeparator = showSeparator
        self.primaryLabelColor = primaryLabelColor
        self.secondaryLabelColor = secondaryLabelColor
        self.collapsedChevronColor = collapsedChevronColor
        self.expandedChevronColor = expandedChevronColor
        self.separatorColor = separatorColor
        self.insets = insets
    }
}
