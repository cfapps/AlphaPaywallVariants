//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SnapKit

extension ConstraintMaker {
    
    func setupSectionHorizontalLayout(_ traitCollection: UITraitCollection) {
        if traitCollection.horizontalSizeClass == .regular {
            width.equalTo(682).priority(.required)
            centerX.equalToSuperview()
            left.greaterThanOrEqualToSuperview().inset(24).priority(.required)
            right.lessThanOrEqualToSuperview().inset(24).priority(.required)
        } else {
            horizontalEdges.equalToSuperview().inset(24)
        }
    }
}
