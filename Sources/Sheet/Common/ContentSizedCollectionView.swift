//
// Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class ContentSizedCollectionView: UICollectionView {
    
    private var contentSizeObservation: NSKeyValueObservation?
    
    var contentSizeDidChangeAction: (() -> Void)?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        let cvHeight = heightAnchor.constraint(equalToConstant: 1)
        cvHeight.isActive = true
        contentSizeObservation = self.observe(\.contentSize, options: .new, changeHandler: { [weak self] (cv, _) in
            cvHeight.constant = max(cv.collectionViewLayout.collectionViewContentSize.height, 1)
            self?.contentSizeDidChangeAction?()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        contentSizeObservation?.invalidate()
    }
}
