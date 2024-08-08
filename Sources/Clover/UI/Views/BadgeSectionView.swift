//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SharedKit

final class BadgeSectionView: UIView {
    
    private var items: [CollectionViewCell.ViewModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = LeftAllignmentCollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 32, height: 12)
        
        let collectionView = ContentSizedCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delaysContentTouches = false
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    var itemBackgroundColor: UIColor = UIColor.secondarySystemBackground
    
    var itemTextColor: UIColor = UIColor.label
    
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
//            make.height.equalTo(150)
        }
    }
}

extension BadgeSectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

extension BadgeSectionView {
    
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = titleTextColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
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
        
        contentContainerView.addSubview(titleLabel)
        
        contentContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(6)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
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
