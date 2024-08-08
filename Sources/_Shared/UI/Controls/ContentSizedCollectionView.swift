//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public class ContentSizedCollectionView: UICollectionView {
    
    private var contentSizeObservation: NSKeyValueObservation?
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        let cvHeight = heightAnchor.constraint(equalToConstant: 2)
        cvHeight.isActive = true
        contentSizeObservation = self.observe(\.contentSize, options: .new, changeHandler: { (cv, _) in
            guard cv.collectionViewLayout.collectionViewContentSize.height > 0 else { return }
            cvHeight.constant = max(cv.collectionViewLayout.collectionViewContentSize.height, 1)
        })
    }
    
    public convenience init(collectionViewLayout layout: UICollectionViewLayout) {
        self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        contentSizeObservation?.invalidate()
    }
}
