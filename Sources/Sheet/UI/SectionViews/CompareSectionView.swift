//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import UIKit
import QuickToolKit

final class CompareSectionView: UIView {
    
    private lazy var collection = QuickCollectionViewCollection()
    private lazy var dataSource = QuickCollectionViewDataSource(collection: collection)
    
    private var optionColumnWidth: CGFloat?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2, weight: .bold)
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private lazy var headerNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = UIColor.blue
        return label
    }()
    
    private lazy var headerOptionOneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = UIColor.blue
        return label
    }()
    
    private lazy var headerOptionTwoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = UIColor.blue
        return label
    }()
    
    private lazy var contentHeaderView = UIView()
    
    private lazy var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.08)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
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
        section.interGroupSpacing = 0
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = ContentSizedCollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.allowsSelection = false
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.layoutMargins = .zero
        
        collectionView.register(cellType: CollectionViewCell.self)
        
        return collectionView
    }()
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var headerText: String? {
        didSet {
            headerNameLabel.text = headerText
        }
    }
    
    var firstOptionText: String? {
        didSet {
            headerOptionOneLabel.text = firstOptionText
        }
    }
    
    var secondOptionText: String? {
        didSet {
            headerOptionTwoLabel.text = secondOptionText
        }
    }
    
    var items: [String] = [] {
        didSet {
            collection.update(sections: [
                QuickCollectionViewSection(
                    items: items.map({
                        return CompareSectionView.CollectionViewCellModel(
                            titleText: $0,
                            hasOptionOne: false,
                            hasOptionTwo: true
                        )
                    })
                )
            ])
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        contentHeaderView.addSubview(headerNameLabel)
        contentHeaderView.addSubview(headerOptionOneLabel)
        contentHeaderView.addSubview(headerOptionTwoLabel)
        
        contentContainerView.addSubview(contentHeaderView)
        contentContainerView.addSubview(collectionView)
        
        addSubview(titleLabel)
        addSubview(contentContainerView)
        
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
            make.top.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentHeaderView.snp.bottom).offset(0)
            make.bottom.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
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

extension CompareSectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? CollectionViewCell {
            cell.optionWidth = optionColumnWidth ?? updateOptionColumnWidth()
        }
    }
}

extension CompareSectionView {
    
    final class CollectionViewCell: UICollectionViewCell {
        
        var labelColor: UIColor = UIColor.label {
            didSet {
                titleLabel.textColor = labelColor
            }
        }
        
        var checkedColor: UIColor = UIColor.blue {
            didSet {
                optionOneCheckmark.checkedColor = checkedColor
                optionTwoCheckmark.checkedColor = checkedColor
            }
        }
        
        var uncheckedColor: UIColor = UIColor.red {
            didSet {
                optionOneCheckmark.uncheckedColor = uncheckedColor
                optionTwoCheckmark.uncheckedColor = uncheckedColor
            }
        }
        
        var titleText: String? {
            didSet {
                titleLabel.text = titleText
            }
        }
        
        var optionWidth: CGFloat = 0 {
            didSet {
                optionOneCheckmark.snp.updateConstraints { make in
                    make.width.equalTo(optionWidth)
                }
                optionTwoCheckmark.snp.updateConstraints { make in
                    make.width.equalTo(optionWidth)
                }
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .bold)
            label.textColor = labelColor
            return label
        }()
        
        private lazy var optionOneCheckmark: CheckmarkView = {
            let checkmark = CheckmarkView()
            checkmark.uncheckedColor = uncheckedColor
            checkmark.checkedColor = checkedColor
            return checkmark
        }()
        
        private lazy var optionTwoCheckmark: CheckmarkView = {
            let checkmark = CheckmarkView()
            checkmark.uncheckedColor = uncheckedColor
            checkmark.checkedColor = checkedColor
            return checkmark
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            
            titleText = nil
        }
        
        private func setupUI() {
            contentView.addSubview(titleLabel)
            contentView.addSubview(optionOneCheckmark)
            contentView.addSubview(optionTwoCheckmark)
            
            titleLabel.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(16)
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(optionOneCheckmark.snp.left)
            }
            
            optionOneCheckmark.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.right.equalTo(optionTwoCheckmark.snp.left)
                make.width.equalTo(0)
            }
            
            optionTwoCheckmark.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.right.equalToSuperview()
                make.width.equalTo(0)
            }
        }
        
        private func makeCheckmark(_ exist: Bool) -> UIImageView {
            let imageView = UIImageView()
            imageView.contentMode = .center
            return imageView
        }
    }
}

extension CompareSectionView.CollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? CompareSectionView.CollectionViewCellModel else {
            return
        }
        
        titleText = model.titleText
        optionOneCheckmark.isChecked = model.hasOptionOne
        optionTwoCheckmark.isChecked = model.hasOptionTwo
    }
}

extension CompareSectionView {
    
    final class CollectionViewCellModel: QuickCollectionViewCellModelProtocol {
        
        var type: QuickCollectionViewCellProtocol.Type { CollectionViewCell.self }
        
        var id: Int?
        
        var entity: StringIdentifiable?
        
        var titleText: String
        
        var hasOptionOne: Bool
        
        var hasOptionTwo: Bool
        
        init(id: Int? = nil,
             entity: StringIdentifiable? = nil,
             titleText: String,
             hasOptionOne: Bool,
             hasOptionTwo: Bool) {
            self.id = id
            self.entity = entity
            self.titleText = titleText
            self.hasOptionOne = hasOptionOne
            self.hasOptionTwo = hasOptionTwo
        }
    }
}

private class CheckmarkView: UIView {
    
    var uncheckedColor: UIColor = UIColor.red {
        didSet {
            guard !isChecked else { return }
            imageView.image = uncheckedImage?.withTintColor(uncheckedColor, renderingMode: .alwaysOriginal)
        }
    }
    
    var checkedColor: UIColor = UIColor.green {
        didSet {
            guard isChecked else { return }
            imageView.image = checkedImage?.withTintColor(checkedColor, renderingMode: .alwaysOriginal)
        }
    }
    
    private var uncheckedImage: UIImage? = {
        UIImage(systemName: "xmark")?
            .applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .heavy)))
    }()
    
    private var checkedImage: UIImage? = {
        UIImage(systemName: "checkmark")?
            .applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .heavy)))
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = uncheckedImage?.withTintColor(uncheckedColor, renderingMode: .alwaysOriginal)
        imageView.contentMode = .center
        return imageView
    }()
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                imageView.image = checkedImage?.withTintColor(checkedColor, renderingMode: .alwaysOriginal)
            } else {
                imageView.image = uncheckedImage?.withTintColor(uncheckedColor, renderingMode: .alwaysOriginal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.left.greaterThanOrEqualToSuperview()
            make.bottom.right.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
    }
}

