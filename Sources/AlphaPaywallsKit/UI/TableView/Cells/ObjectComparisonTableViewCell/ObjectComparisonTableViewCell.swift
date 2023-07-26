//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit
import SnapKit

final class ObjectComparisonTableViewCell: UITableViewCell {
    
    private let collection = QuickCollectionViewCollection()
    
    var contentBackgroundColor: UIColor = UIColor.tertiarySystemBackground {
        didSet {
            backgroundContentView.backgroundColor = contentBackgroundColor
        }
    }
    
    var textLabelColor: UIColor = UIColor.label
    
    var positiveColor: UIColor = UIColor.label
    
    var negativeColor: UIColor = UIColor.red
    
    var containerInsets: UIEdgeInsets = .zero {
        didSet {
            backgroundContentView.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(containerInsets.top)
                make.bottom.equalToSuperview().inset(containerInsets.bottom)
                make.left.equalToSuperview().inset(containerInsets.left)
                make.right.equalToSuperview().inset(containerInsets.right)
            }
        }
    }
    
    private lazy var backgroundContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = contentBackgroundColor
        return view
    }()
    
    private lazy var itemHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = textLabelColor
        return label
    }()
    
    private lazy var firstOptionHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = textLabelColor
        return label
    }()
    
    private lazy var secondOptionHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = textLabelColor
        return label
    }()
    
    private lazy var contentHeaderView = UIView()
    
    private lazy var contentContainerView = UIView()
    
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
    
    private var optionColumnWidth: CGFloat?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateOptionColumnWidth()
        
        if let width = optionColumnWidth, firstOptionHeaderLabel.frame.width != width {
            firstOptionHeaderLabel.snp.updateConstraints { make in
                make.width.equalTo(width).priority(.medium)
            }
            secondOptionHeaderLabel.snp.updateConstraints { make in
                make.width.equalTo(width).priority(.medium)
            }
        }
    }
    
    private func setupUI() {
        backgroundView = UIView()
        selectedBackgroundView = UIView()
        backgroundColor = .clear
        
        contentHeaderView.addSubview(itemHeaderLabel)
        contentHeaderView.addSubview(firstOptionHeaderLabel)
        contentHeaderView.addSubview(secondOptionHeaderLabel)
        
        contentContainerView.addSubview(contentHeaderView)
        contentContainerView.addSubview(collectionView)
        
        contentView.addSubview(backgroundContentView)
        contentView.addSubview(contentContainerView)
        
        backgroundContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.edges.equalTo(backgroundContentView).inset(8)
        }
        
        itemHeaderLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.right.lessThanOrEqualTo(firstOptionHeaderLabel.snp.left).offset(-8)
        }
        
        firstOptionHeaderLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.right.equalTo(secondOptionHeaderLabel.snp.left)
            make.width.equalTo(0).priority(.medium)
        }
        
        secondOptionHeaderLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.right.equalToSuperview()
            make.width.equalTo(0).priority(.medium)
        }
        
        contentHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentHeaderView.snp.bottom)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1).priority(.medium)
        }
    }
    
    @discardableResult
    private func updateOptionColumnWidth() -> CGFloat {
        let maxWidth = collectionView.frame.width * 0.4
        var calculatedWidth = [secondOptionHeaderLabel.text, secondOptionHeaderLabel.text]
            .compactMap({ $0 })
            .map({ UILabel.calculateSize($0, font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold), width: maxWidth / 2).width })
            .max() ?? 0
        
        calculatedWidth = min(calculatedWidth + 24, maxWidth)
        optionColumnWidth = calculatedWidth > 0 ? calculatedWidth : nil
        return calculatedWidth
    }
}

extension ObjectComparisonTableViewCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collection.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.numberOfItems(in: section)
    }
}

extension ObjectComparisonTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellType = collection.cellType(at: indexPath),
              let cell = collectionView.dequeue(cellType: cellType, for: indexPath) as? QuickCollectionViewCellProtocol,
              let cellModel = collection.cell(at: indexPath) else {
            fatalError("Cell cannot be dequeue")
        }
        
        cell.update(model: cellModel)
        
        if let cell = cell as? CollectionViewCell {
            cell.textColor = textLabelColor
            cell.positiveColor = positiveColor
            cell.negativeColor = negativeColor
            cell.optionWidth = optionColumnWidth ?? updateOptionColumnWidth()
        }
        
        return cell
    }
}
extension ObjectComparisonTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? ObjectComparisonTableViewCellModel else {
            return
        }
        
        optionColumnWidth = nil
        
        itemHeaderLabel.textColor = model.headerTextColor
        firstOptionHeaderLabel.textColor = model.headerTextColor
        secondOptionHeaderLabel.textColor = model.headerTextColor
        
        textLabelColor = model.textColor
        contentBackgroundColor = model.backgroundColor
        
        positiveColor = model.positiveColor
        negativeColor = model.negativeColor
        
        itemHeaderLabel.text = model.nameColumnHeader
        firstOptionHeaderLabel.text = model.aColumnHeader
        secondOptionHeaderLabel.text = model.bColumnHeader
        
        updateOptionColumnWidth()
        
        collection.update(sections: [
            QuickCollectionViewSection(
                items: model.items.map({
                    CollectionViewCellModel(text: $0)
                })
            )
        ])
        
        collectionView.reloadData()
        
        containerInsets = model.insets
    }
}
