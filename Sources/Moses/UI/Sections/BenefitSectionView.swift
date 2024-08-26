//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SharedKit

final class BenefitSectionView: UIView {
    
    struct ViewModel {
        
        let iconImage: UIImage?
        
        let titleText: String
    }
    
    private var items: [ViewModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (_, environment) -> NSCollectionLayoutSection? in
            guard let self = self else {
                return nil
            }
            
            let containerWidth = environment.container.contentSize.width
            let contentWidth = min(containerWidth - 48, 682)
            
            var calculatedItemHeight: CGFloat = CollectionViewCell.calculateSize().height
            let itemWidth: CGFloat = 160.0
            
            let item: NSCollectionLayoutItem
            let group: NSCollectionLayoutGroup
            let section: NSCollectionLayoutSection
            
            item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidth),
                heightDimension: .absolute(calculatedItemHeight)
            ))
            
            group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .absolute(calculatedItemHeight)
                ),
                subitem: item,
                count: 1
            )
            group.interItemSpacing = .fixed(0)
            
            section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0,
                leading: (containerWidth - contentWidth) / 2,
                bottom: 0,
                trailing: (containerWidth - contentWidth) / 2
            )
            
            return section
        })
        
        let collectionView = ContentSizedCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delaysContentTouches = false
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.alwaysBounceVertical = false
        collectionView.allowsSelection = true
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    var itemBackgroundColor: UIColor = UIColor.tertiarySystemBackground
    
    var primaryLabelColor: UIColor = UIColor.label
    
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

extension BenefitSectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            fatalError("Cannot dequeue cell")
        }
        
        cell.textColor = primaryLabelColor
        cell.contentBackgroundColor = itemBackgroundColor
        
        if items.count > indexPath.item {
            let item = items[indexPath.item]
            cell.configure(with: item)
        }
        
        return cell
    }
}

extension BenefitSectionView {
    
    func update(items: [ViewModel]) {
        self.items = items
        
        collectionView.reloadData()
    }
}

private final class CollectionViewCell: UICollectionViewCell {
    
    private static let titleLabelFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Self.titleLabelFont
        label.textColor = textColor
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var blurBackgroundView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = contentBackgroundColor
        return view
    }()
    
    var textColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = textColor
        }
    }
    
    var contentBackgroundColor: UIColor = UIColor.systemGroupedBackground {
        didSet {
            blurBackgroundView.backgroundColor = contentBackgroundColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        backgroundView = blurBackgroundView
        
        let containerIconImageView: UIView = {
            let view = UIView()
            
            view.addSubview(iconImageView)
            
            iconImageView.snp.makeConstraints { make in
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
                make.center.equalToSuperview()
            }
            
            return view
        }()
        
        contentView.addSubview(containerIconImageView)
        contentView.addSubview(titleLabel)
        
        containerIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(12)
            make.right.lessThanOrEqualToSuperview().offset(-12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerIconImageView.snp.bottom).offset(12)
            make.bottom.equalToSuperview().inset(12)
            make.directionalHorizontalEdges.equalToSuperview().inset(12)
        }
    }
}

extension CollectionViewCell {
    
    func configure(with viewModel: BenefitSectionView.ViewModel) {
        iconImageView.image = viewModel.iconImage
        titleLabel.text = viewModel.titleText
    }
}

extension CollectionViewCell {
    
    static func calculateSize() -> CGSize {
        var height: CGFloat = 0
        
        height += 24 // vertical insets
        height += 30 // icon height
        height += 12 // inset between icon and title
        height += calculateLabelHeight(Self.titleLabelFont) // title height
        
        return CGSize(width: height, height: height)
    }
    
    private static func calculateLabelHeight(_ font: UIFont) -> CGFloat {
        let label = UILabel()
        label.text = "_\n_"
        label.font = font
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label.systemLayoutSizeFitting(
            CGSize.zero,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel
        ).height
    }
}
