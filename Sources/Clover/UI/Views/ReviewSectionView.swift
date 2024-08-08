//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SharedKit

final class ReviewSectionView: UIView {
    
    private var items: [CollectionViewCell.ViewModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (_, environment) -> NSCollectionLayoutSection? in
            guard let self = self else {
                return nil
            }
            
            let containerWidth = environment.container.contentSize.width
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(76)
            ))
            
            let group: NSCollectionLayoutGroup
            let section: NSCollectionLayoutSection
            
            if traitCollection.horizontalSizeClass == .regular {
                let groupWidth = min(682, containerWidth - 48)
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(groupWidth),
                        heightDimension: .estimated(437.667)
                    ),
                    subitem: item,
                    count: 1
                )
                group.interItemSpacing = .fixed(0)
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = min(((containerWidth - groupWidth) / 2) - 32, 8)
                section.orthogonalScrollingBehavior = .groupPagingCentered
            } else {
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(containerWidth - 48),
                        heightDimension: .estimated(437.667)
                    ),
                    subitem: item,
                    count: 1
                )
                group.interItemSpacing = .fixed(0)
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.orthogonalScrollingBehavior = .groupPagingCentered
            }
            
            return section
        })
        
        let collectionView = ContentSizedCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delaysContentTouches = false
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    var itemBackgroundColor: UIColor = UIColor.secondarySystemFill
    
    var itemTextColor: UIColor = UIColor.label
    
    init() {
        super.init(frame: .zero)
        
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

extension ReviewSectionView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            fatalError("Cannot dequeue cell")
        }
        
        if items.count > indexPath.item {
            cell.configure(with: items[indexPath.item])
        }
        
        cell.contentBackgroundColor = itemBackgroundColor
        cell.titleTextColor = itemTextColor
        
        return cell
    }
}

extension ReviewSectionView {
    
    func append(body: String) {
        items.append(CollectionViewCell.ViewModel(body: body))
    }
}

private final class CollectionViewCell: UICollectionViewCell {
    
    private lazy var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = contentBackgroundColor
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private var starFillImage: UIImage? {
        UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(
            UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 15, weight: .regular))
        )
    }
    
    private lazy var rateStackView: UIStackView = {
        func makeRateImageView() -> UIView {
            let containerView: UIView = {
                let view = UIView()
                return view
            }()
            
            let imageView = UIImageView(
                image: starFillImage?.withTintColor(titleTextColor, renderingMode: .alwaysOriginal)
            )
            
            containerView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
                make.center.equalToSuperview()
            }
            
            containerView.snp.makeConstraints { make in
                make.width.height.equalTo(20)
            }
            
            return containerView
        }
        
        let stackView = UIStackView(
            arrangedSubviews: [
                makeRateImageView(),
                makeRateImageView(),
                makeRateImageView(),
                makeRateImageView(),
                makeRateImageView()
            ]
        )
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = titleTextColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var contentBackgroundColor: UIColor = UIColor.quaternarySystemFill {
        didSet {
            contentContainerView.backgroundColor = contentBackgroundColor
        }
    }
    
    var titleTextColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = titleTextColor
            for subView in rateStackView.arrangedSubviews.compactMap({ $0.subviews.first as? UIImageView }) {
                subView.image = starFillImage?.withTintColor(titleTextColor, renderingMode: .alwaysOriginal)
            }
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
        contentView.addSubview(contentContainerView)
        
        contentContainerView.addSubview(rateStackView)
        contentContainerView.addSubview(titleLabel)
        
        contentContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        rateStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(rateStackView.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(24)
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
        }
    }
    
    func configure(with viewModel: ViewModel) {
        titleLabel.text = viewModel.body
    }
}

extension CollectionViewCell {
    
    struct ViewModel {
        
        let body: String
    }
}
