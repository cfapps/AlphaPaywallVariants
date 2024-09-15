//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import Lottie
import SharedKit

final class BenefitSectionView: UIView {
    
    private typealias Item = (String, UIImage?)
    
    private var items: [Item] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = titleTextColor
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var titleLabelContainerView = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (_, _) -> NSCollectionLayoutSection? in
            guard let self = self else {
                return nil
            }
            
            let layoutSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: layoutSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .groupPagingCentered
            section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, point, env) -> Void in
                guard let self = self else { return }
                
                self.didChangePage(Int((point.x / self.collectionView.frame.width).rounded(.toNearestOrAwayFromZero)))
            }
            
            return section
        })
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        collectionView.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: "FeatureCollectionViewCell")
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    var titleTextColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var pageIndicatorTintColor: UIColor = UIColor.gray {
        didSet {
            pageControl.pageIndicatorTintColor = pageIndicatorTintColor
        }
    }
    
    var currentPageIndicatorTintColor: UIColor = UIColor.systemBlue {
        didSet {
            pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabelContainerView.addSubview(titleLabel)
        
        addSubview(titleLabelContainerView)
        addSubview(collectionView)
        addSubview(pageControl)
        
        titleLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabelContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(snp.top).offset(13)
            make.height.equalTo(UILabel.calculateLabelHeight("_\n_", titleLabel.font))
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabelContainerView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(24)
        }
        
        pageControl.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func didChangePage(_ index: Int) {
        guard index != pageControl.currentPage, items.count > index else {
            return
        }
        
        pageControl.currentPage = index
        titleLabel.text = items[index].0
    }
}

extension BenefitSectionView {
    
    func append(title: String, image: UIImage?) {
        items.append((title, image))
        pageControl.numberOfPages = items.count
    }
    
    func reloadItems() {
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
        pageControl.currentPage = 0
        
        if items.count > 0 {
            titleLabel.text = items[0].0
        } else {
            titleLabel.text = ""
        }
        
        collectionView.reloadData()
        pageControl.layoutIfNeeded()
    }
}

extension BenefitSectionView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionViewCell", for: indexPath) as? FeatureCollectionViewCell else {
            fatalError("Cannot dequeue cell")
        }
        
        if items.count > indexPath.item {
            cell.image = items[indexPath.item].1
        }
        
        return cell
    }
}

private final class FeatureCollectionViewCell: UICollectionViewCell {
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var containerContentImageView = UIView()
    
    var image: UIImage? {
        didSet {
            contentImageView.image = image
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
        containerContentImageView.addSubview(contentImageView)
        
        contentView.addSubview(containerContentImageView)
        
        contentImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        containerContentImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}
