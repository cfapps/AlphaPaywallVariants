//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class OptionsTableViewCell: UITableViewCell {
    
    private weak var model: OptionsTableViewCellModel?
    
    private let collection = QuickCollectionViewCollection()
    
    private var labelColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = labelColor
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .bold)
        label.textColor = .orange
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .estimated(123)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(123)
            ),
            subitem: item,
            count: 2
        )
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        
        collectionView.layoutMargins = .zero
        
        collectionView.register(cellType: CollectionViewCellModel.type)
        
        return collectionView
    }()
    
    private lazy var containerView = UIView()
    
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
        backgroundColor = UIColor.clear
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(collectionView)
        contentView.addSubview(containerView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(1).priority(.medium)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
}

extension OptionsTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collection.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.numberOfItems(in: section)
    }
}

extension OptionsTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = collection.cellType(at: indexPath),
              let cell = collectionView.dequeue(cellType: cellType, for: indexPath) as? QuickCollectionViewCellProtocol,
              let cellModel = collection.cell(at: indexPath) else {
            fatalError("Cell cannot be dequeue")
        }
        
        cell.update(model: cellModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard (model?.items.count ?? 0) > indexPath.item, let item = model?.items[indexPath.item] else {
            return
        }
        
        titleLabel.text = item.detailsText
        model?.selectedItemId = item.id
        
        if let tableView = self.superview as? UITableView {
            UIView.performWithoutAnimation {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        
        model?.didSelectItem?(item)
    }
}

extension OptionsTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? OptionsTableViewCellModel else {
            return
        }
        
        self.model = model
        
        labelColor = model.labelColor
        
        collection.removeAll()
        
        collection.update(sections: [
            QuickCollectionViewSection(
                items: model.items.map({ item in
                    return CollectionViewCellModel(
                        id: nil,
                        entity: nil,
                        titleText: item.titleText,
                        descriptionText: item.descriptionText,
                        badge: item.badge.flatMap({
                            CollectionViewCellModel.Badge(text: $0.text, color: $0.color, textColor: $0.textColor)
                        }),
                        backgroundColor: model.backgroundColor,
                        labelColor: model.labelColor,
                        unselectedColor: model.unselectedColor,
                        selectedColor: model.selectedColor
                    )
                })
            )
        ])
        
        collectionView.reloadData()
        
        if let selectedItemId = model.selectedItemId, let index = model.items.firstIndex(where: { $0.id == selectedItemId }) {
            collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: [])
            titleLabel.text = model.items[index].detailsText
        } else {
            titleLabel.text = nil
        }
        
        collectionView.layoutIfNeeded()
        
        containerView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(model.inset.top)
            make.bottom.equalToSuperview().inset(model.inset.bottom)
            make.left.equalToSuperview().inset(model.inset.left)
            make.right.equalToSuperview().inset(model.inset.right)
        }
        
        DispatchQueue.main.async {
            if let tableView = self.superview as? UITableView {
                UIView.performWithoutAnimation {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            }
        }
    }
}
