//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SharedKit

final class ProductsSectionView: UIView {
    
    struct ViewModel {
        
        let id: String
        
        let titleText: String
        
        let descriptionText: String
        
        let badgeText: String?
        
        let freeText: String?
        
        let priceText: String
        
        let priceDescriptionText: String
        
        let priceBadgeText: String?
        
        let durationText: String
        
        let actionText: String
        
        let options: [(UIImage?, String)]
    }
    
    private var items: [ProductsSectionView.ViewModel] = []
    
    private var indicatedItemIndexPath: IndexPath?
    
    private var focusingItemIndexPath: IndexPath?
    
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
                heightDimension: .estimated(437.667)
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
                section.interGroupSpacing = max(((containerWidth - groupWidth) / 2) - 32, 8)
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
            
            section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, point, env) -> Void in
                guard let self = self else { return }
                
                let index = Int((point.x / self.collectionView.frame.width).rounded(.toNearestOrAwayFromZero))
                if self.items.count > index {
                    self.changeFocusedItemAction?(self.items[index].id)
                }
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
    
    var itemBackgroundColor: UIColor = UIColor.secondarySystemBackground
    
    var itemBorderColor: UIColor = UIColor.separator
    
    var itemPrimaryTextColor: UIColor = UIColor.label
    
    var itemSecondaryTextColor: UIColor = UIColor.secondaryLabel
    
    var accentColor: UIColor = UIColor.tertiarySystemBackground
    
    var invertAccentColor: UIColor = UIColor.tertiaryLabel
    
    var changeFocusedItemAction: ((String) -> Void)?
    
    var selectItemAction: ((String) -> Void)?
    
    var isEnabled: Bool = true {
        didSet {
            for cell in collectionView.visibleCells.compactMap({ $0 as? CollectionViewCell }) {
                cell.isEnabled = isEnabled
            }
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let indexPath = focusingItemIndexPath {
            focusingItemIndexPath = nil
            collectionView.scrollToItem(at: indexPath, at: [], animated: false)
        }
    }
    
    private func setupUI() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ProductsSectionView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            fatalError("Cannot dequeue cell")
        }
        
        cell.backgroundContentColor = itemBackgroundColor
        cell.borderContentColor = itemBorderColor.withAlphaComponent(0.12)
        cell.labelPrimaryColor = itemPrimaryTextColor
        cell.labelSecondaryColor = itemSecondaryTextColor
        cell.labelAccentColor = invertAccentColor
        cell.accentColor = accentColor
        
        cell.badgeBackgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell.badgeTextColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        cell.priceBadgeBackgroundColor = UIColor(red: 0.2, green: 0.78, blue: 0.35, alpha: 1)
        cell.priceBadgeTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        if items.count > indexPath.item {
            cell.configure(with: items[indexPath.item])
        }
        
        if indexPath == indicatedItemIndexPath {
            cell.showIndication()
        } else if isEnabled && indicatedItemIndexPath == nil {
            cell.isEnabled = true
        } else {
            cell.isEnabled = false
        }
        
        cell.primaryButtonAction = { [weak self] (id) in
            guard self?.isEnabled == true else { return }
            self?.selectItemAction?(id)
        }
        
        return cell
    }
}

extension ProductsSectionView {
    
    func update(items: [ProductsSectionView.ViewModel], selectedItemId: String?) {
        self.items = items
        collectionView.reloadData()
        if let index = items.firstIndex(where: { $0.id == selectedItemId }) {
            focusingItemIndexPath = IndexPath(item: index, section: 0)
        }
    }
    
    func showIndication() {
        guard let indexPath = collectionView.indexPathForItem(at: CGPoint(x: collectionView.frame.width / 2, y: collectionView.frame.height / 2)) else {
            return
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            indicatedItemIndexPath = indexPath
            cell.showIndication()
        }
        
        for cell in collectionView.visibleCells.compactMap({ $0 as? CollectionViewCell }) {
            cell.isEnabled = false
        }
    }
    
    func hideIndication() {
        guard let indexPath = indicatedItemIndexPath else {
            return
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
            cell.hideIndication()
        }
        
        for cell in collectionView.visibleCells.compactMap({ $0 as? CollectionViewCell }) {
            cell.isEnabled = true
        }
        
        indicatedItemIndexPath = nil
    }
}

private final class CollectionViewCell: UICollectionViewCell {
    
    private var entityId: String?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var headerBadgeLabel: BadgeLabel = {
        let label = BadgeLabel()
        label.textColor = badgeTextColor
        label.backgroundColor = badgeBackgroundColor
        label.isCornersRounded = true
        return label
    }()
    
    private lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = accentColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = labelPrimaryColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var descriptionSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = labelSecondaryColor
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = labelPrimaryColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var priceSubTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = labelSecondaryColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var priceBadgeLabel: BadgeLabel = {
        let label = BadgeLabel()
        label.textColor = priceBadgeTextColor
        label.backgroundColor = priceBadgeBackgroundColor
        label.isCornersRounded = true
        return label
    }()
    
    private lazy var actionButton: PrimaryButton = {
        let button = PrimaryButton()
        
        button.backgroundContentColor = accentColor
        button.textColor = labelAccentColor
        
        button.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var headerContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var descriptionContainerView = UIView()
    
    private lazy var priceContainerView = UIView()
    
    private lazy var optionsContainerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()
    
    var backgroundContentColor: UIColor = UIColor.secondarySystemBackground {
        didSet {
            contentView.backgroundColor = backgroundContentColor
        }
    }
    
    var borderContentColor: UIColor = UIColor.separator {
        didSet {
            contentView.layer.borderColor = borderContentColor.cgColor
        }
    }
    
    var labelPrimaryColor: UIColor = UIColor.label {
        didSet {
            headerBadgeLabel.textColor = labelPrimaryColor
            descriptionTitleLabel.textColor = labelPrimaryColor
            priceTitleLabel.textColor = labelPrimaryColor
        }
    }
    
    var labelSecondaryColor: UIColor = UIColor.secondaryLabel {
        didSet {
            descriptionSubTitleLabel.textColor = labelSecondaryColor
            priceSubTitleLabel.textColor = labelSecondaryColor
        }
    }
    
    var labelAccentColor: UIColor = UIColor.label {
        didSet {
            actionButton.textColor = labelAccentColor
        }
    }
    
    var accentColor: UIColor = UIColor.magenta {
        didSet {
            headerTitleLabel.textColor = accentColor
            actionButton.backgroundContentColor = accentColor
        }
    }
    
    var badgeBackgroundColor: UIColor = UIColor.secondarySystemGroupedBackground {
        didSet {
            headerBadgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    var badgeTextColor: UIColor = UIColor.label {
        didSet {
            headerBadgeLabel.textColor = badgeTextColor
        }
    }
    
    var priceBadgeBackgroundColor: UIColor = UIColor.quaternarySystemFill {
        didSet {
            priceBadgeLabel.backgroundColor = priceBadgeBackgroundColor
        }
    }
    
    var priceBadgeTextColor: UIColor = UIColor.label {
        didSet {
            priceBadgeLabel.textColor = priceBadgeTextColor
        }
    }
    
    var primaryButtonAction: ((String) -> Void)?
    
    var isEnabled: Bool = true {
        didSet {
            guard actionButton.isEnabled != isEnabled else { return }
            actionButton.isEnabled = isEnabled
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
        
        actionButton.hideIndication()
//        isEnabled = true
        
        for view in optionsContainerView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    
    private func setupUI() {
        contentView.backgroundColor = backgroundContentColor
        contentView.layer.borderColor = borderContentColor.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(containerView)
        
        headerContainerView.addSubview(headerBadgeLabel)
        headerContainerView.addSubview(headerTitleLabel)
        
        descriptionContainerView.addSubview(descriptionTitleLabel)
        descriptionContainerView.addSubview(descriptionSubTitleLabel)
        
        priceContainerView.addSubview(priceTitleLabel)
        priceContainerView.addSubview(priceSubTitleLabel)
        priceContainerView.addSubview(priceBadgeLabel)
        
        containerView.addSubview(headerContainerView)
        containerView.addSubview(descriptionContainerView)
        containerView.addSubview(priceContainerView)
        containerView.addSubview(actionButton)
        containerView.addSubview(optionsContainerView)
        
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        headerBadgeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        headerTitleLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        headerContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalToSuperview()
            make.height.equalTo(calculateHeaderContainerView())
        }
        
        descriptionTitleLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        descriptionSubTitleLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(descriptionTitleLabel.snp.bottom).offset(6)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        descriptionContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(headerContainerView.snp.bottom).offset(16)
            
            make.height.equalTo(calculateDescriptionContainerView())
        }
        
        priceTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.top.equalToSuperview()
            make.right.equalTo(priceBadgeLabel.snp.left).offset(-8)
        }
        
        priceSubTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.top.equalTo(priceTitleLabel.snp.bottom)
            make.bottom.equalToSuperview()
            make.right.equalTo(priceBadgeLabel.snp.left).offset(-8)
        }
        
        priceBadgeLabel.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.left.greaterThanOrEqualTo(priceContainerView.snp.centerX)
        }
        
        priceContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(descriptionContainerView.snp.bottom).offset(16)
            
            make.height.equalTo(calculatePriceContainerView())
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(priceContainerView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview()
        }
        
        optionsContainerView.snp.makeConstraints { make in
            make.top.equalTo(actionButton.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    @objc private func didTapActionButton() {
        guard let entityId = entityId, entityId.isEmpty == false else {
            return
        }
        
        primaryButtonAction?(entityId)
    }
    
    private func calculateHeaderContainerView() -> CGFloat {
        return 24
    }
    
    private func calculateDescriptionContainerView() -> CGFloat {
        return 100.67
    }
    
    private func calculatePriceContainerView() -> CGFloat {
        return 47
    }
    
    private func calculateActionButton() -> CGFloat {
        return 46.33
    }
}

extension CollectionViewCell {
    
    private func makeOptionView(image: UIImage?, text: String) -> UIView {
        let view = UIView()
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        let imageContainerView = UIView()
        
        imageContainerView.addSubview(imageView)
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = labelSecondaryColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = text
        
        view.addSubview(imageContainerView)
        view.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(label.snp.left)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(label)
        }
        
        label.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview()
        }
        
        return view
    }
}

extension CollectionViewCell {
    
    func configure(with viewModel: ProductsSectionView.ViewModel) {
        entityId = viewModel.id
        
        if viewModel.badgeText?.isEmpty == false {
            headerBadgeLabel.text = viewModel.badgeText
            headerBadgeLabel.isHidden = false
        } else {
            headerBadgeLabel.isHidden = true
        }
        headerTitleLabel.text = viewModel.freeText
        
        descriptionTitleLabel.text = viewModel.titleText
        descriptionSubTitleLabel.text = viewModel.descriptionText
        actionButton.text = viewModel.actionText
        
        configurePriceTitle(viewModel.priceText, viewModel.durationText)
        priceSubTitleLabel.text = viewModel.priceDescriptionText
        
        priceBadgeLabel.text = viewModel.priceBadgeText
        if viewModel.priceBadgeText?.isEmpty != false {
            priceBadgeLabel.isHidden = true
        } else {
            priceBadgeLabel.isHidden = false
        }
        
        for view in optionsContainerView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        for (image, text) in viewModel.options {
            optionsContainerView.addArrangedSubview(makeOptionView(image: image, text: text))
        }
    }
    
    private func configurePriceTitle(_ priceText: String, _ priceUnitText: String) {
        let attributedText = NSMutableAttributedString(string: [priceText, priceUnitText].filter({ $0.isEmpty == false }).joined(separator: " / "))
        attributedText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 22, weight: .regular),
            range: NSRange(location: 0, length: priceText.count)
        )
        attributedText.addAttribute(
            .font,
            value: UIFont.systemFont(ofSize: 17, weight: .regular),
            range: NSRange(location: priceText.count + 1, length: priceUnitText.count)
        )
        priceTitleLabel.attributedText = attributedText
    }
    
    func showIndication() {
        actionButton.showIndication()
    }
    
    func hideIndication() {
        actionButton.hideIndication()
    }
}
