//
// Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

public final class ContentSizedTableView: UITableView {
    
    public override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
