//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import UIKit
import QuickToolKit

final class FeatureSectionView: UIView {
    
    struct Item {
        
        let icon: ItemIcon
        
        let text: String
    }
    
    enum ItemIcon: String {
        
        case clients = "person.2"
        case documents = "doc.plaintext"
        case reminders = "envelope.arrow.triangle.branch"
        case reports = "chart.line.uptrend.xyaxis"
        case restrictions = "checkmark.seal"
    }
    
    private lazy var collection = QuickCollectionViewCollection()
    private lazy var dataSource = QuickCollectionViewDataSource(collection: collection)
    
    private var calculatedMaxWidth: CGFloat = 0
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            )
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = ContentSizedCollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(cellType: FeatureCollectionViewCell.self)
        collectionView.allowsSelection = false
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var iconColor: UIColor = UIColor.blue
    
    var textColor: UIColor = UIColor.label
    
    var items: [Item] = [] {
        didSet {
            calculatedMaxWidth = items.map({ FeatureCollectionViewCell.calculateWidth(text: $0.text) }).max() ?? 0
            collection.update(sections: [
                QuickCollectionViewSection(
                    items: items.map({
                        FeatureCollectionViewCellModel(
                            iconImageName: $0.icon.rawValue,
                            text: $0.text
                        )
                    })
                )
            ])
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FeatureSectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? FeatureCollectionViewCell else {
            return
        }
        
        cell.horizontalOffset = (collectionView.frame.width - calculatedMaxWidth) / 2
    }
}
