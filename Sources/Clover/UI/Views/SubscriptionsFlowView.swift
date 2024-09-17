//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SharedKit

final class SubscriptionsFlowView: UIView {
    
    struct ViewModel {
        
        let id: String
        
        let titleText: String
        
        let subTitleText: String
        
        let detailsText: String
        
        let subDetailsText: String
        
        let descriptionText: String
        
        let subDescriptionText: String
        
        let badgeText: String?
        
        let actionText: String
    }
    
    private var initialized = false
    private var dissmissStarted: Bool = false
    private var isIndication: Bool = false
    
    private var items: [ViewModel] = []
    
    private lazy var tongueView: UIView = {
        let view = UIView()
        view.backgroundColor = tongueColor
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.black
//        view.alpha = 0.3
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = contentBackgroundColor
        return view
    }()
    
    private lazy var primaryButton: PrimaryButton = {
        let button = PrimaryButton()
        button.textFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.textColor = primaryButtonTextColor
        button.backgroundContentColor = primaryButtonBackgroundColor
        button.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor.white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private lazy var detailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = detailsBackgroundColor
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (_, environment) -> NSCollectionLayoutSection? in
            guard let self = self else {
                return nil
            }
            
            let containerWidth = environment.container.contentSize.width
            let contentWidth = min(containerWidth - 48, 682)
            
            let itemsCount = traitCollection.horizontalSizeClass == .regular ? 3.0 : 3.0
            let itemWidth = (contentWidth - 8.0 * (itemsCount - 1.0)) / itemsCount
            
            let estimatedHeight = CollectionViewCell.estimatedHeight
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidth),
                heightDimension: .absolute(estimatedHeight)
            ))
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .absolute(estimatedHeight)
                ),
                subitem: item,
                count: 1
            )
            group.interItemSpacing = .fixed(0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
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
        collectionView.alwaysBounceHorizontal = false
        collectionView.allowsSelection = true
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    var contentSize: CGSize {
        return contentView.bounds.size
    }
    
    var contentBackgroundColor: UIColor = UIColor.systemBackground {
        didSet {
            contentView.backgroundColor = contentBackgroundColor
        }
    }
    
    var itemBackgroundColor: UIColor = UIColor.systemGroupedBackground
    
    var itemSelectedBackgroundColor: UIColor = UIColor.tertiarySystemGroupedBackground
    
    var detailsBackgroundColor: UIColor = UIColor.systemGroupedBackground {
        didSet {
            detailsContainerView.backgroundColor = detailsBackgroundColor
        }
    }
    
    var textColor: UIColor = UIColor.white
    
    var primaryButtonBackgroundColor: UIColor = UIColor.systemGroupedBackground {
        didSet {
            primaryButton.backgroundContentColor = primaryButtonBackgroundColor
        }
    }
    
    var primaryButtonTextColor: UIColor = UIColor.label {
        didSet {
            primaryButton.textColor = primaryButtonTextColor
        }
    }
    
    var tongueColor: UIColor = UIColor.separator {
        didSet {
            tongueView.backgroundColor = tongueColor
        }
    }
    
    var accentColor: UIColor = UIColor.blue
    
    var isEnabled: Bool = true {
        didSet {
            collectionView.isUserInteractionEnabled = isEnabled
            primaryButton.isEnabled = isEnabled
        }
    }
    
    var didTapItem: ((String) -> Void)?
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard !initialized else { return }
        initialized = true
        
        DispatchQueue.main.async {
            let contentViewHeight = self.contentView.bounds.size.height
            self.contentView.snp.updateConstraints { make in
                make.top.equalTo(self.snp.bottom).offset(-contentViewHeight)
            }
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
    
    private func setupUI() {
//        contentView.addSubview(movingView)
        contentView.addSubview(tongueView)
        contentView.addSubview(collectionView)
        
        
        detailsContainerView.addSubview(detailsLabel)
        contentView.addSubview(detailsContainerView)
        
        contentView.addSubview(primaryButton)
        
        addSubview(dimmingView)
        addSubview(contentView)
        
        tongueView.snp.makeConstraints { make in
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.height.equalTo(4)
            make.width.equalTo(32)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(16)
            make.horizontalEdges.equalToSuperview()
        }
        
        detailsLabel.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
            make.top.greaterThanOrEqualToSuperview().inset(24)
            make.bottom.lessThanOrEqualToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        detailsContainerView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(UILabel.calculateLabelHeight("_\n_", detailsLabel.font) + 48)
        }
        
        primaryButton.snp.makeConstraints { make in
            make.top.equalTo(detailsContainerView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        
        dimmingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.snp.bottom).offset(0)
        }
        
        dimmingView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didTapDimmingView)))
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDimmingView)))
        
        contentView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(didPanTongue)))
    }
    
    func update(items: [ViewModel], selectedItemId: String?) {
        self.items = items
        collectionView.reloadData()
        if let index = items.firstIndex(where: { $0.id == selectedItemId }) {
            collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: [])
            let item = items[index]
            detailsLabel.text = item.subDetailsText
            primaryButton.text = item.actionText
        }
    }
    
    @objc private func didTapPrimaryButton() {
        guard let index = collectionView.indexPathsForSelectedItems?.first?.item, index < items.count else {
            return
        }
        
        let itemId = items[index].id
        didTapItem?(itemId)
    }
    
    @objc private func didTapDimmingView() {
        guard isEnabled, !isIndication else { return }
        
        dismissView()
    }
    
    @objc private func didPanTongue(_ gesture: UIPanGestureRecognizer) {
        guard isEnabled, !isIndication else { return }
        
        let contentViewHeight = contentView.bounds.size.height
        let yPoint = gesture.translation(in: contentView).y
        
        switch gesture.state {
        case .ended, .cancelled:
            if yPoint > (contentViewHeight * 0.3) {
                dismissView()
            } else {
                contentView.snp.updateConstraints { make in
                    make.top.equalTo(self.snp.bottom).offset(-contentViewHeight)
                }
                
                UIView.animate(
                    withDuration: 0.2,
                    animations: {
                        self.layoutIfNeeded()
                    }
                )
            }
        default:
            if yPoint > 0 {
                let offset = yPoint - contentViewHeight
                contentView.snp.updateConstraints { make in
                    make.top.equalTo(self.snp.bottom).offset(offset)
                }
            }
        }
    }
    
    private func dismissView() {
        guard !dissmissStarted else { return }
        dissmissStarted = true
        contentView.snp.updateConstraints { make in
            make.top.equalTo(self.snp.bottom).offset(0)
        }
        
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.layoutIfNeeded()
            },
            completion: { [weak self] (result) in
                self?.removeFromSuperview()
            }
        )
    }
}

extension SubscriptionsFlowView {
    
    func show() {
        
    }
    
    func showIndicationPrimaryButton() {
        isIndication = true
        collectionView.isUserInteractionEnabled = false
        
        primaryButton.showIndication()
    }
    
    func hideIndicationPrimaryButton() {
        isIndication = false
        collectionView.isUserInteractionEnabled = true
        
        primaryButton.hideIndication()
    }
}

extension SubscriptionsFlowView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            fatalError("Cannot dequeue cell")
        }
        
        cell.unselectedContentBackgroundColor = itemBackgroundColor
        cell.selectedContentBackgroundColor = itemSelectedBackgroundColor
        cell.accentColor = accentColor
        cell.labelColor = textColor
        
        if items.count > indexPath.item {
            let item = items[indexPath.item]
            cell.badgeText = item.badgeText
            cell.titleText = item.titleText
            cell.subTitleText = item.subTitleText
            cell.detailsText = item.detailsText
            cell.descriptionText = item.descriptionText
            cell.subDescriptionText = item.subDescriptionText
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        guard index < items.count else {
            return
        }
        
        let item = items[index]
        
        detailsLabel.text = item.subDetailsText
        primaryButton.text = item.actionText
    }
}

private final class CollectionViewCell: UICollectionViewCell {
    
    private static let badgeLabelFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
    private static let titleLabelFont = UIFont.systemFont(ofSize: 34, weight: .bold)
    private static let subTitleLabelFont = UIFont.systemFont(ofSize: 11, weight: .semibold)
    private static let detailsLabelFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    private static let descriptionLabelFont = UIFont.systemFont(ofSize: 11, weight: .regular)
    private static let subDescriptionLabelFont = UIFont.systemFont(ofSize: 11, weight: .regular)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = unselectedContentBackgroundColor
        view.layer.borderColor = accentColor.cgColor
        return view
    }()
    
    private lazy var badgeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
        view.backgroundColor = accentColor
        view.isHidden = true
        return view
    }()
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.font = Self.badgeLabelFont
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Self.titleLabelFont
        label.textColor = labelColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = Self.subTitleLabelFont
        label.textColor = labelColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = Self.detailsLabelFont
        label.textColor = labelColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Self.descriptionLabelFont
        label.textColor = labelColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Self.subDescriptionLabelFont
        label.textColor = labelColor
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        return label
    }()
    
    private lazy var cView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subTitleLabel,
            detailsLabel,
            descriptionLabel,
            subDescriptionLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        
        stackView.spacing = 2
        stackView.setCustomSpacing(12, after: subTitleLabel)
        
        return stackView
    }()
    
    private var infinityImage: UIImage? {
        return UIImage(systemName: "infinity")?
            .withConfiguration(UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 34, weight: .regular)))
            .withTintColor(labelColor, renderingMode: .alwaysOriginal)
    }
    
    var unselectedContentBackgroundColor: UIColor = UIColor.systemGroupedBackground {
        didSet {
            containerView.backgroundColor = resolveBackgroundColor()
        }
    }
    
    var selectedContentBackgroundColor: UIColor = UIColor.tertiarySystemGroupedBackground {
        didSet {
            containerView.backgroundColor = resolveBackgroundColor()
        }
    }
    
    var accentColor: UIColor = UIColor.blue {
        didSet {
            badgeView.backgroundColor = accentColor
            containerView.layer.borderColor = accentColor.cgColor
        }
    }
    
    var labelColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = labelColor
            subTitleLabel.textColor = labelColor
            detailsLabel.textColor = labelColor
            descriptionLabel.textColor = labelColor
            subDescriptionLabel.textColor = labelColor
        }
    }
    
    var badgeText: String? {
        didSet {
            if let text = badgeText, !text.isEmpty {
                badgeLabel.text = text
                badgeView.isHidden = false
            } else {
                badgeLabel.text = nil
                badgeView.isHidden = true
            }
        }
    }
    
    var titleText: String? {
        didSet {
            if titleText == "􀯠" {
                if let image = infinityImage {
                    let font = UIFont.systemFont(ofSize: 34, weight: .regular)
                    let imageAttachment = NSTextAttachment()
                    imageAttachment.image = image
                    imageAttachment.bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
                    titleLabel.attributedText = NSAttributedString(attachment: imageAttachment)
                } else {
                    titleLabel.text = titleText
                }
            } else {
                titleLabel.text = titleText
            }
        }
    }
    
    var subTitleText: String? {
        didSet {
            subTitleLabel.text = subTitleText
        }
    }
    
    var detailsText: String? {
        didSet {
            detailsLabel.text = detailsText
        }
    }
    
    var descriptionText: String? {
        didSet {
            if let text = descriptionText, !text.isEmpty {
                descriptionLabel.text = text
                descriptionLabel.isHidden = false
            } else {
                descriptionLabel.text = nil
                descriptionLabel.isHidden = true
            }
        }
    }
    
    var subDescriptionText: String? {
        didSet {
            if let text = subDescriptionText, !text.isEmpty {
                subDescriptionLabel.text = text
                subDescriptionLabel.isHidden = false
            } else {
                subDescriptionLabel.text = nil
                subDescriptionLabel.isHidden = true
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
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = resolveBackgroundColor()
            containerView.layer.borderWidth = isSelected ? 2 : 0
        }
    }
    
    private func setupUI() {
        containerView.addSubview(cView)
        
        contentView.addSubview(containerView)
        
        badgeView.addSubview(badgeLabel)
        contentView.addSubview(badgeView)
        
        cView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(((UILabel.calculateLabelHeight("_", Self.badgeLabelFont) + 2) / 2) - 1)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        badgeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(1)
            make.bottom.equalToSuperview().inset(1)
            make.directionalHorizontalEdges.equalToSuperview().inset(6)
        }
        
        badgeView.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(containerView.snp.left)
            make.right.lessThanOrEqualTo(containerView.snp.right)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    private func resolveBackgroundColor() -> UIColor {
        return isSelected ? selectedContentBackgroundColor : unselectedContentBackgroundColor
    }
}

extension CollectionViewCell {
    
    static var estimatedHeight: CGFloat {
        return (((UILabel.calculateLabelHeight("_", Self.badgeLabelFont) + 2) / 2) - 1)
            + UILabel.calculateLabelHeight("_", Self.titleLabelFont)
            + UILabel.calculateLabelHeight("_", Self.subTitleLabelFont)
            + UILabel.calculateLabelHeight("_", Self.detailsLabelFont)
            + UILabel.calculateLabelHeight("_", Self.descriptionLabelFont)
            + UILabel.calculateLabelHeight("_", Self.subDescriptionLabelFont)
            + 52
    }
}
