//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class FeaturesTableViewCell: UITableViewCell {
    
    private let collection = QuickCollectionViewCollection()
    
    private var itemMaxWidth: CGFloat = 0
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(44)
            ),
            subitem: item,
            count: 1
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(cellType: CollectionViewCellModel.type)
        collectionView.allowsSelection = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension FeaturesTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collection.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.numberOfItems(in: section)
    }
}

extension FeaturesTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = collection.cellType(at: indexPath),
              let cell = collectionView.dequeue(cellType: cellType, for: indexPath) as? QuickCollectionViewCellProtocol,
              let cellModel = collection.cell(at: indexPath) else {
            fatalError("Cell cannot be dequeue")
        }
        
        cell.update(model: cellModel)
        
        if let cell = cell as? CollectionViewCell {
            cell.horizontalOffset = (collectionView.bounds.width - itemMaxWidth) / 2
        }
        
        return cell
    }
}

extension FeaturesTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? FeaturesTableViewCellModel else {
            return
        }
        
        collection.removeAll()
        
        itemMaxWidth = model.items.map({ CollectionViewCell.calculateWidth(text: $0.text) }).max() ?? 0
        
        collection.update(sections: [
            QuickCollectionViewSection(
                items: model.items.map({
                    CollectionViewCellModel(icon: $0.icon, text: $0.text)
                })
            )
        ])
        
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
}
