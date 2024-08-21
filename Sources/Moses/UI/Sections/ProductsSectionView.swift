//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SharedKit

final class ProductsSectionView: UIView {
    
    struct ViewModel {
        
        let id: String
        
        let titleText: String
        
        let subTitleText: String
        
        let detailsText: String
        
        let subDetailsText: String
        
        let badgeColor: UIColor?
        
        let badgeTextColor: UIColor?
        
        let badgeText: String?
        
        let descriptionText: String
    }
    
    private var items: [ViewModel] = []
    
    private var indicatedItemIndexPath: IndexPath?
    
    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (_, environment) -> NSCollectionLayoutSection? in
            guard let self = self else {
                return nil
            }
            
            let containerWidth = environment.container.contentSize.width
            let contentWidth = min(containerWidth - 48, 682)
            
            var calculatedItemWidth = CollectionViewCell.calculateSize().width
            let targetItemWidth = (contentWidth - 8) / 2
            
            let item: NSCollectionLayoutItem
            let group: NSCollectionLayoutGroup
            let section: NSCollectionLayoutSection
            
            if targetItemWidth < calculatedItemWidth * 0.9 {
                item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(calculatedItemWidth),
                    heightDimension: .absolute(calculatedItemWidth)
                ))
                
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(calculatedItemWidth),
                        heightDimension: .absolute(calculatedItemWidth)
                    ),
                    subitem: item,
                    count: 1
                )
                group.interItemSpacing = .fixed(0)
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.orthogonalScrollingBehavior = .paging
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: (containerWidth - contentWidth) / 2,
                    bottom: 0,
                    trailing: (containerWidth - contentWidth) / 2
                )
            } else {
                let itemsCount = traitCollection.horizontalSizeClass == .regular ? 3.0 : 2.0
                let itemWidth = (contentWidth - 8.0 * (itemsCount - 1.0)) / itemsCount
                
                item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .absolute(itemWidth)
                ))
                
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .absolute(itemWidth),
                        heightDimension: .absolute(itemWidth)
                    ),
                    subitem: item,
                    count: 1
                )
                group.interItemSpacing = .fixed(0)
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.orthogonalScrollingBehavior = .paging
                section.contentInsets = NSDirectionalEdgeInsets(
                    top: 0,
                    leading: (containerWidth - contentWidth) / 2,
                    bottom: 0,
                    trailing: (containerWidth - contentWidth) / 2
                )
            }
            
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
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = secondaryLabelColor
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var selectItemAction: ((String) -> Void)?
    
    var accentColor: UIColor = UIColor.systemGreen
    
    var primaryLabelColor: UIColor = UIColor.label
    
    var secondaryLabelColor: UIColor = UIColor.secondaryLabel {
        didSet {
            detailsLabel.textColor = secondaryLabelColor
        }
    }
    
    var itemBackgroundColor: UIColor = UIColor.tertiarySystemBackground
    
    var itemSeparatorColor: UIColor = UIColor.tertiarySystemGroupedBackground
    
    var isEnabled: Bool = false {
        didSet {
            collectionView.isUserInteractionEnabled = isEnabled
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
        addSubview(collectionView)
        addSubview(detailsLabel)
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
        }
        
        detailsLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.bottom.equalToSuperview().offset(0)
        }
    }
}

extension ProductsSectionView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            fatalError("Cannot dequeue cell")
        }
        
        cell.accentColor = accentColor
        cell.textColor = primaryLabelColor
        cell.contentBackgroundColor = itemBackgroundColor
        cell.contentBorderColor = itemSeparatorColor
        
        if items.count > indexPath.item {
            let item = items[indexPath.item]
            cell.configure(with: item)
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard items.count > indexPath.item else {
            return
        }
        
        let item = items[indexPath.item]
        detailsLabel.text = item.descriptionText
        selectItemAction?(item.id)
    }
}

extension ProductsSectionView {
    
    func update(items: [ViewModel], selectedItemId: String?) {
        self.items = items
        collectionView.reloadData()
        if let index = items.firstIndex(where: { $0.id == selectedItemId }) {
            collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: [.left])
            detailsLabel.text = items[index].descriptionText
        }
    }
}

private final class CollectionViewCell: UICollectionViewCell {
    
    private static var titleLabelFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    private static var subTitleLabelFont = UIFont.systemFont(ofSize: 28, weight: .bold)
    private static var detailsLabelFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    private static var subDetailsLabelFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    
    private var entityId: String?
    private var viewModel: ProductsSectionView.ViewModel?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = contentBorderColor.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var circleImage: UIImage? = {
        var image = UIImage(systemName: "circle")
        image = image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 22)))
        return image
    }()
    
    private lazy var checkmarkImage: UIImage? = {
        var image = UIImage(systemName: "checkmark.circle.fill")
        image = image?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 22)))
        return image
    }()
    
    private lazy var uncheckedImageView: UIImageView = {
        let imageView = UIImageView(image: circleImage?.withTintColor(contentBorderColor, renderingMode: .alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var checkedImageView: UIImageView = {
        let imageView = UIImageView(image: checkmarkImage?.withTintColor(accentColor, renderingMode: .alwaysOriginal))
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var badgeLabel: BadgeLabel = {
        let label = BadgeLabel()
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Self.titleLabelFont
        label.textColor = textColor
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Self.subTitleLabelFont
        label.textColor = textColor
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = Self.detailsLabelFont
        label.textColor = textColor
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var subDetailsLabel: UILabel = {
        let label = UILabel()
        label.font = Self.subDetailsLabelFont
        label.textColor = textColor
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var accentColor: UIColor = UIColor.darkText {
        didSet {
            updateTextColor()
            checkedImageView.image = checkmarkImage?.withTintColor(accentColor, renderingMode: .alwaysOriginal)
        }
    }
    
    var textColor: UIColor = UIColor.label {
        didSet {
            updateTextColor()
        }
    }
    
    var contentBackgroundColor: UIColor = UIColor.systemBackground {
        didSet {
            containerView.backgroundColor = contentBackgroundColor
        }
    }
    
    var contentBorderColor: UIColor = UIColor.separator {
        didSet {
            containerView.layer.borderColor = resolveBorderColor().cgColor
            uncheckedImageView.image = circleImage?.withTintColor(contentBorderColor, renderingMode: .alwaysOriginal)
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            updateTextColor()
            
            containerView.layer.borderColor = resolveBorderColor().cgColor
            
            checkedImageView.isHidden = !isSelected
            uncheckedImageView.isHidden = isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupUI() {
        containerView.backgroundColor = contentBackgroundColor
        
        containerView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let headerContainerView: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 24))
            
            let imageContainerView = UIView()
            imageContainerView.addSubview(uncheckedImageView)
            imageContainerView.addSubview(checkedImageView)
            
            uncheckedImageView.snp.makeConstraints { make in
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
                make.center.equalToSuperview()
            }
            
            checkedImageView.snp.makeConstraints { make in
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
                make.center.equalToSuperview()
            }
            
            view.addSubview(imageContainerView)
            
            imageContainerView.snp.makeConstraints { make in
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.left.equalToSuperview()
                make.width.height.equalTo(22)
                make.centerY.equalToSuperview()
            }
            
            view.addSubview(badgeLabel)
            
            badgeLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.right.equalToSuperview()
                make.left.greaterThanOrEqualTo(imageContainerView.snp.right).offset(8)
            }
            
            return view
        }()
        
        let priceContainerView: UIView = {
            let view = UIView()
            view.addSubview(titleLabel)
            view.addSubview(subTitleLabel)
            view.addSubview(detailsLabel)
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.directionalHorizontalEdges.equalToSuperview()
            }
            
            subTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(4)
                make.directionalHorizontalEdges.equalToSuperview()
            }
            
            detailsLabel.snp.makeConstraints { make in
                make.top.equalTo(subTitleLabel.snp.bottom).offset(4)
                make.bottom.equalToSuperview()
                make.directionalHorizontalEdges.equalToSuperview()
            }
            
            return view
        }()
        
        contentStackView.addArrangedSubview(headerContainerView)
        contentStackView.addArrangedSubview(priceContainerView)
        contentStackView.addArrangedSubview(subDetailsLabel)
    }
    
    private func updateTextColor() {
        titleLabel.textColor = resolveTextColor()
        subTitleLabel.textColor = resolveTextColor()
        detailsLabel.textColor = resolveTextColor()
        subDetailsLabel.textColor = resolveTextColor()
        if let text = viewModel?.subDetailsText {
            subDetailsLabel.attributedText = attributedString(text, subDetailsLabel.font, subDetailsLabel.textColor)
        }
    }
    
    private func resolveTextColor() -> UIColor {
        if isSelected {
            return accentColor
        }
        
        return textColor
    }
    
    private func resolveBorderColor() -> UIColor {
        if isHighlighted || isSelected {
            return accentColor
        }
        
        return contentBorderColor
    }
}

extension CollectionViewCell {
    
    func configure(with viewModel: ProductsSectionView.ViewModel) {
        self.viewModel = viewModel
        
        entityId = viewModel.id
        
        titleLabel.text = viewModel.titleText
        subTitleLabel.text = viewModel.subTitleText
        detailsLabel.text = viewModel.detailsText
        subDetailsLabel.attributedText = attributedString(viewModel.subDetailsText, subDetailsLabel.font, subDetailsLabel.textColor)
        
        badgeLabel.textColor = viewModel.badgeTextColor ?? badgeLabel.textColor
        badgeLabel.backgroundColor = viewModel.badgeColor ?? badgeLabel.backgroundColor
        
        if let text = viewModel.badgeText, !text.isEmpty {
            badgeLabel.text = text
            badgeLabel.isHidden = false
        } else {
            badgeLabel.text = nil
            badgeLabel.isHidden = true
        }
    }
    
    static func calculateSize() -> CGSize {
        var height: CGFloat = 0
        
        height += 32 // vertical insets
        height += 24 // header
        height += 6 // inset between header and title
        height += calculateLabelHeight(Self.titleLabelFont) // title height
        height += 4 // inset between title and subTitle
        height += calculateLabelHeight(Self.subTitleLabelFont) // subTitle height
        height += 4 // inset between subTitle and details
        height += calculateLabelHeight(Self.detailsLabelFont) // details height
        height += 6 // inset between details and subDetails
        height += calculateLabelHeight(Self.subDetailsLabelFont) // subDetails height
        
        return CGSize(width: height, height: height)
    }
    
    private static func calculateLabelHeight(_ font: UIFont) -> CGFloat {
        let label = UILabel()
        label.text = "_"
        label.font = font
        
        return label.systemLayoutSizeFitting(
            CGSize.zero,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel
        ).height
    }
    
    private func attributedString(_ string: String, _ font: UIFont, _ textColor: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "")
        let targetUnicodeValue: UInt32 = 1049674
        
        for character in string {
            if let unicodeScalar = character.unicodeScalars.first, unicodeScalar.value == targetUnicodeValue {
                let attachment = NSTextAttachment()
                attachment.image = UIImage(systemName: "gift.fill")?.withTintColor(textColor, renderingMode: .alwaysOriginal)
                attachment.bounds = CGRect(x: 0, y: (font.capHeight - 16) / 2, width: 16, height: 16)
                attributedString.append(NSAttributedString(attachment: attachment))
            } else {
                attributedString.append(NSAttributedString(string: String(character)))
            }
        }
        
        return attributedString
    }
}
