//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import UIKit
import QuickToolKit

final class ReviewSectionView: UIView {
    
    struct Item {
        
        let nameText: String
        
        let subjectText: String
        
        let bodyText: String
    }
    
    enum ItemIcon: String {
        
        case bolt = "bolt.fill"
        case bell = "bell.fill"
        case starOfLife = "staroflife.fill"
    }
    
    private lazy var collection = QuickCollectionViewCollection()
    private lazy var dataSource = QuickCollectionViewDataSource(collection: collection)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2, weight: .bold)
        label.textColor = titleTextColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
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
        section.interGroupSpacing = 16
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = ContentSizedCollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.allowsSelection = false
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layoutMargins = .zero
        collectionView.register(cellType: ReviewCollectionViewCell.self)
        return collectionView
    }()
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var items: [Item] = [] {
        didSet {
            collection.update(sections: [
                QuickCollectionViewSection(
                    items: items.map({
                        ReviewCollectionViewCellModel(
                            name: $0.nameText,
                            subject: $0.subjectText,
                            body: $0.bodyText
                        )
                    })
                )
            ])
            collectionView.reloadData()
        }
    }
    
    var titleTextColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var itemBackgroundColor: UIColor = UIColor.tertiarySystemBackground
    
    var itemTitleTextColor: UIColor = UIColor.label
    
    var itemSubTitleTextColor: UIColor = UIColor.secondaryLabel
    
    var itemDetailsTextColor: UIColor = UIColor.tertiaryLabel
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }
}

extension ReviewSectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.numberOfSections(in: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dataSource.collectionView(collectionView, cellForItemAt: indexPath)
        
        if let cell = cell as? ReviewCollectionViewCell {
            cell.subjectTextColor = itemTitleTextColor
            cell.bodyTextColor = itemSubTitleTextColor
            cell.nameTextColor = itemDetailsTextColor
            cell.contentBackgroundColor = itemBackgroundColor
        }
        
        return cell
    }
}
