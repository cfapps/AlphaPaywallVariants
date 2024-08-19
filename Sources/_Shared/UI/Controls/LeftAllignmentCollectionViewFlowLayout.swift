//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public class LeftAllignmentCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var rows = [CollectionViewRow]()
        var currentRowY: CGFloat = -1
        
        for attribute in attributes {
            if currentRowY != attribute.frame.midY {
                currentRowY = attribute.frame.midY
                rows.append(CollectionViewRow(spacing: 8))
            }
            rows.last?.add(attribute: attribute)
        }
        
        rows.forEach { $0.alignLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
        return rows.flatMap { $0.attributes }
    }
}

private final class CollectionViewRow {
    
    private var spacing: CGFloat = 0
    
    private(set) var attributes: [UICollectionViewLayoutAttributes] = []
    
    init(spacing: CGFloat) {
        self.spacing = spacing
    }
    
    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }
    
    var rowWidth: CGFloat {
        return attributes.reduce(0, { result, attribute -> CGFloat in
            return result + attribute.frame.width
        }) + CGFloat(attributes.count - 1) * spacing
    }
    
    func alignLayout(collectionViewWidth: CGFloat) {
        let padding = (collectionViewWidth - rowWidth) / 2
        var offset: CGFloat = 0.0
        for attribute in attributes {
            attribute.frame.origin.x = offset
            offset += attribute.frame.width + spacing
        }
    }
}
