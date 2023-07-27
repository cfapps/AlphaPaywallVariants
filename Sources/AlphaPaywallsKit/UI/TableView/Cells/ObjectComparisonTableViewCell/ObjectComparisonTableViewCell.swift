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
    
    var headerLabelColor: UIColor = UIColor.label {
        didSet {
            headerNameLabel.textColor = headerLabelColor
            headerOptionOneLabel.textColor = headerLabelColor
            headerOptionTwoLabel.textColor = headerLabelColor
        }
    }
    
    var itemLabelColor: UIColor = UIColor.label
    
    var checkedColor: UIColor = UIColor.systemGreen
    
    var unchecked: UIColor = UIColor.systemRed
    
    var insets: UIEdgeInsets = .zero {
        didSet {
            backgroundContentView.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(insets.top)
                make.bottom.equalToSuperview().inset(insets.bottom)
                make.left.equalToSuperview().inset(insets.left)
                make.right.equalToSuperview().inset(insets.right)
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
    
    private lazy var headerNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = headerLabelColor
        return label
    }()
    
    private lazy var headerOptionOneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = headerLabelColor
        return label
    }()
    
    private lazy var headerOptionTwoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = headerLabelColor
        return label
    }()
    
    private lazy var contentHeaderView = UIView()
    
    private lazy var contentContainerView = UIView()
    
    private lazy var collectionViewLayout: UICollectionViewLayout = {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(50)
            )
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(50)
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
        
        if let width = optionColumnWidth, headerOptionOneLabel.frame.width != width {
            headerOptionOneLabel.snp.updateConstraints { make in
                make.width.equalTo(width).priority(.medium)
            }
            headerOptionTwoLabel.snp.updateConstraints { make in
                make.width.equalTo(width).priority(.medium)
            }
        }
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentHeaderView.addSubview(headerNameLabel)
        contentHeaderView.addSubview(headerOptionOneLabel)
        contentHeaderView.addSubview(headerOptionTwoLabel)
        
        contentContainerView.addSubview(contentHeaderView)
        contentContainerView.addSubview(collectionView)
        
        backgroundContentView.addSubview(contentContainerView)
        
        contentView.addSubview(backgroundContentView)
        
        backgroundContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        headerNameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.right.lessThanOrEqualTo(headerOptionOneLabel.snp.left).offset(-8)
        }
        
        headerOptionOneLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.right.equalTo(headerOptionTwoLabel.snp.left)
            make.width.equalTo(0).priority(.medium)
        }
        
        headerOptionTwoLabel.snp.makeConstraints { make in
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
        var calculatedWidth = [headerOptionTwoLabel.text, headerOptionTwoLabel.text]
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
            cell.labelColor = itemLabelColor
            cell.checkedColor = checkedColor
            cell.uncheckedColor = unchecked
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
        
        contentBackgroundColor = model.contentBackgroundColor
        headerLabelColor = model.headerLabelColor
        itemLabelColor = model.itemLabelColor
        checkedColor = model.checkedColor
        unchecked = model.uncheckedColor
        
        headerNameLabel.text = model.headerNameText
        headerOptionOneLabel.text = model.headerOptionOneText
        headerOptionTwoLabel.text = model.headerOptionTwoText
        
        collection.update(sections: [
            QuickCollectionViewSection(
                items: model.items.map({
                    CollectionViewCellModel(
                        titleText: $0.text,
                        hasOptionOne: $0.hasOptionOne,
                        hasOptionTwo: $0.hasOptionTwo
                    )
                })
            )
        ])
        
        collectionView.reloadData()
        
        insets = model.insets
    }
}
