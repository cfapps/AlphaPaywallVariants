//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class ReviewsTableViewCell: UITableViewCell {
    
    private let collection = QuickCollectionViewCollection()
    
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
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(cellType: CollectionViewCell.self)
        collectionView.allowsSelection = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    var contentBackgroundColor: UIColor = UIColor.systemBackground
    
    var nameLabelColor: UIColor = UIColor.tertiaryLabel
    
    var subjectLabelColor: UIColor = UIColor.tertiaryLabel
    
    var bodyLabelColor: UIColor = UIColor.tertiaryLabel
    
    var insets: UIEdgeInsets = .zero {
        didSet {
            collectionView.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(insets.top)
                make.bottom.equalToSuperview().inset(insets.bottom)
                make.left.equalToSuperview().inset(insets.left)
                make.right.equalToSuperview().inset(insets.right)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        collection.removeAll()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
//            make.height.equalTo(1)//.priority(.medium)
            make.horizontalEdges.equalToSuperview()
        }
    }
}

extension ReviewsTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collection.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.numberOfItems(in: section) ?? 0
    }
}

extension ReviewsTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = collection.cellType(at: indexPath),
              let cell = collectionView.dequeue(cellType: cellType, for: indexPath) as? QuickCollectionViewCellProtocol,
              let cellModel = collection.cell(at: indexPath) else {
            fatalError("Cell cannot be dequeue")
        }
        
        if let cell = cell as? CollectionViewCell {
            cell.contentBackgroundColor = contentBackgroundColor
            cell.nameLabelColor = nameLabelColor
            cell.subjectLabelColor = subjectLabelColor
            cell.bodyLabelColor = bodyLabelColor
        }
        
        cell.update(model: cellModel)
        
        return cell
    }
}

extension ReviewsTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? ReviewsTableViewCellModel else {
            return
        }
        
        contentBackgroundColor = model.contentBackgroundColor
        nameLabelColor = model.nameLabelColor
        subjectLabelColor = model.subjectLabelColor
        bodyLabelColor = model.bodyLabelColor
        
        collection.update(sections: [
            QuickCollectionViewSection(
                items: model.items.map({
                    CollectionViewCellModel(name: $0.name, subject: $0.subject, body: $0.body)
                })
            )
        ])
        
        insets = model.insets
        
        collectionView.reloadData()
        collectionView.performBatchUpdates { }
    }
}
