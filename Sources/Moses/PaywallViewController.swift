//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SnapKit
import Lottie
import PaywallsKit
import SharedKit

open class PaywallViewController: UIViewController {
    
    private let viewModel: PaywallViewModel
    
    private let colorAppearance: ColorAppearance
    
    private lazy var closeBarButton: UIButton = {
        let image = UIImage(systemName: "xmark.circle.fill")?
            .withConfiguration(UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 28, weight: .semibold)))
            .withTintColor(colorAppearance.tertiaryLabel)
            .withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.delegate = self
        scrollView.delaysContentTouches = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var privacyPolicyButton: TextButton = {
        let button = TextButton()
        button.contentInsets = UIEdgeInsets(top: 11, left: 2, bottom: 11, right: 2)
        button.textFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.textColor = colorAppearance.secondaryLabel
        button.addTarget(self, action: #selector(didTapPrivacyPolicyButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var termsOfServiceButton: TextButton = {
        let button = TextButton()
        button.contentInsets = UIEdgeInsets(top: 11, left: 2, bottom: 11, right: 2)
        button.textFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.textColor = colorAppearance.secondaryLabel
        button.addTarget(self, action: #selector(didTapTermsOfServiceButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var restoreButton: TextButton = {
        let button = TextButton()
        button.contentInsets = UIEdgeInsets(top: 11, left: 2, bottom: 11, right: 2)
        button.textFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.textColor = colorAppearance.secondaryLabel
        button.addTarget(self, action: #selector(didTapRestoreButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var productsSectionView: ProductsSectionView = {
        let view = ProductsSectionView()
        
//        view.itemBackgroundColor = colorAppearance.tertiarySystemBackground
//        view.itemBorderColor = colorAppearance.separator
//        view.itemPrimaryTextColor = colorAppearance.label
//        view.itemSecondaryTextColor = colorAppearance.secondaryLabel
//        view.accentColor = colorAppearance.accent
//        view.invertAccentColor = colorAppearance.accentLabel
        
        view.selectItemAction = { [weak self] (id) in
            self?.didChangeProduct(id)
        }
        
        return view
    }()
    
    private lazy var progressSectionContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var connectButton: PrimaryButton = {
        let button = PrimaryButton()
        button.textFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.textColor = colorAppearance.accentLabel
        button.backgroundContentColor = colorAppearance.accent
        button.addTarget(self, action: #selector(didTapConnectButton), for: .touchUpInside)
        return button
    }()
    
    private var contentTopConstraint: ConstraintItem {
        guard let view = contentView.subviews.last else {
            return contentView.snp.top
        }
        
        return view.snp.bottom
    }
    
    public weak var delegate: PaywallViewControllerDelegate?
    
    public init(viewModel: PaywallViewModel, colorAppearance: ColorAppearance) {
        self.viewModel = viewModel
        self.colorAppearance = colorAppearance
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bottomInset = connectButton.bounds.height + 28
        scrollView.contentInset.bottom = bottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
    }
    
    private func setupUI() {
        view.backgroundColor = colorAppearance.systemBackground
        
        navigationController?.navigationBar.barTintColor = colorAppearance.navigationBarTint
        
        scrollView.addSubview(contentView)
        
        view.addSubview(scrollView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
            make.width.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        setupContentView()
        
        // hack for scroll view insets
        DispatchQueue.main.async {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupContentView() {
        configureHeaderView()
        configureBenefitView()
        configureProductsView()
        configureAwardView()
        configureProgressSection()
        configureReviewView()
        configureFeatureView()
        configureHelpSection()
        configureFooterSection()
        configureStubSection()
        configureBottomActionsSection()
    }
    
    private func configureHeaderView() {
        let topConstraint = self.contentTopConstraint
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            label.textColor = colorAppearance.label
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            return label
        }()
        
        let subTitleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            label.textColor = colorAppearance.label
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            return label
        }()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(8)
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
        }
        
        let mutableString = NSMutableAttributedString()
        var startIndex: Int?
        for c in viewModel.title {
            guard c == "*" else {
                mutableString.append(NSAttributedString(string: "\(c)"))
                continue
            }
            
            if let index = startIndex {
                mutableString.addAttribute(
                    .foregroundColor,
                    value: colorAppearance.accent,
                    range: NSRange(location: index, length: mutableString.length - index)
                )
                startIndex = nil
            } else {
                startIndex = mutableString.length
            }
        }
        titleLabel.attributedText = mutableString
        subTitleLabel.text = viewModel.subTitle
    }
    
    private func configureBenefitView() {
        var topConstraint = self.contentTopConstraint
        var topOffset = 0
        
        if let animation = viewModel.headerAnimation.flatMap({ try? LottieAnimation.from(data: $0) }) {
            let animationView = LottieAnimationView()
            animationView.contentMode = .scaleAspectFit
            animationView.animation = animation
            
            contentView.addSubview(animationView)
            
            animationView.snp.makeConstraints { make in
                make.top.equalTo(topConstraint).offset(28)
                make.setupSectionHorizontalLayout(traitCollection)
                make.height.equalTo(animationView.snp.width).multipliedBy(animation.size.height / animation.size.width)
            }
            
            animationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop)
            
            topConstraint = animationView.snp.bottom
            topOffset = -20
        }
        
        guard let model = viewModel.benefit, model.items.count > 0 else {
            return
        }
        
        let view = BenefitSectionView()
        
        view.primaryLabelColor = colorAppearance.label
        view.itemBackgroundColor = colorAppearance.secondarySystemBackground
        
        view.update(items: model.items.map({
            BenefitSectionView.ViewModel(
                iconImage: $0.icon?.withTintColor(colorAppearance.accent, renderingMode: .alwaysOriginal),
                titleText: $0.title
            )
        }))
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(topOffset)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    private func configureProductsView() {
        if let text = viewModel.productHeader {
            appendHeader(text)
        }
        
        let topConstraint = self.contentTopConstraint
        
        productsSectionView.accentColor = colorAppearance.accent
        productsSectionView.primaryLabelColor = colorAppearance.label
        productsSectionView.secondaryLabelColor = colorAppearance.secondaryLabel
        productsSectionView.itemBackgroundColor = colorAppearance.systemBackground
        productsSectionView.itemSeparatorColor = colorAppearance.separator
        
        productsSectionView.update(
            items: viewModel.product.items.map({ product in
                ProductsSectionView.ViewModel(
                    id: product.id,
                    titleText: product.title,
                    subTitleText: product.price,
                    detailsText: product.priceDetails,
                    subDetailsText: product.priceDescription,
                    badgeColor: UIColor.yellow,
                    badgeTextColor: UIColor.white,
                    badgeText: product.badgeText,
                    descriptionText: product.description
                )
            }),
            selectedItemId: viewModel.product.selectedItemId
        )
        
        contentView.addSubview(productsSectionView)
        
        productsSectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(topConstraint).offset(24)
        }
    }
    
    private func configureAwardView() {
        guard let model = viewModel.award else {
            return
        }
        
        let topConstraint = self.contentTopConstraint
        
        let view = AwardSectionView()
        
        view.contentBackgroundColor = colorAppearance.accent
        view.detailsTextColor = colorAppearance.accentLabel
        
        view.detailsText = model.title
        view.image = model.icon
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(48)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureProgressSection() {
        let topConstraint = self.contentTopConstraint
        
        contentView.addSubview(progressSectionContainerView)
        
        progressSectionContainerView.snp.makeConstraints { make in
            make.top.equalTo(topConstraint)
            make.setupSectionHorizontalLayout(traitCollection)
        }
        
        guard let item = viewModel.product.selectedItemId.flatMap({ id in viewModel.product.items.first(where: { $0.id == id }) }) else {
            return
        }
        
        if let view = makePregressSection(item) {
            progressSectionContainerView.addSubview(view)
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func configureReviewView() {
        guard let model = viewModel.review else {
            return
        }
        
        if let text = viewModel.reviewsHeader {
            appendHeader(text)
        }
        
        let topConstraint = self.contentTopConstraint
        
        let view = ReviewSectionView()
        
        view.itemBackgroundColor = colorAppearance.secondarySystemBackground
        view.itemNameTextColor = colorAppearance.secondaryLabel
        view.itemBodyTextColor = colorAppearance.label
        
        for item in model.items {
            view.append(name: item.name, body: item.text, image: item.image)
        }
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(24)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureFeatureView() {
        guard let model = viewModel.feature else {
            return
        }
        
        if let text = viewModel.featureHeader {
            appendHeader(text)
        }
        
        let topConstraint = self.contentTopConstraint
        
        let view = FeatureSectionView()
        
        view.contentBackgroundColor = colorAppearance.secondarySystemBackground
        view.headerTitleTextColor = colorAppearance.secondaryLabel
        view.headerBasicTextColor = colorAppearance.secondaryLabel
        view.headerBasicBackgroundColor = colorAppearance.featureBasicBadgeFill
        view.headerPremiumTextColor = colorAppearance.secondaryLabel
        view.headerPremiumBackgroundColor = colorAppearance.featurePremiumBadgeFill
        view.itemTextColor = colorAppearance.label
        view.availableOptionImage = UIImage(
            systemName: "checkmark.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 17, weight: .regular))
        )?.withTintColor(UIColor(red: 0.2, green: 0.78, blue: 0.35, alpha: 1), renderingMode: .alwaysOriginal)
        view.unavailableOptionImage = UIImage(
            systemName: "lock.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 17, weight: .regular))
        )?.withTintColor(UIColor(red: 1, green: 0.23, blue: 0.19, alpha: 1), renderingMode: .alwaysOriginal)
        
        view.headerTitleText = model.title
        view.headerBasicOptionText = model.basic
        view.headerPremiumOptionText = model.premium
        
        for item in model.items {
            view.append(
                title: item.text,
                isAvailableBasic: item.isAvailableBasic,
                isAvailablePremium: item.isAvailablePremium
            )
        }
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(24)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureHelpSection() {
        guard let model = viewModel.help else {
            return
        }
        
        if let text = viewModel.helpHeader {
            appendHeader(text)
        }
        
        let topConstraint = self.contentTopConstraint
        
        let view = HelpSectionView()
        
        view.itemBackgroundColor = colorAppearance.secondarySystemBackground
        view.itemTitleTextColor = colorAppearance.label
        view.itemDescriptionTextColor = colorAppearance.secondaryLabel
        view.chevronCollapsedColor = colorAppearance.secondaryLabel
        view.chevronExpandedColor = colorAppearance.tertiaryLabel
        
        for item in model.items {
            view.append(title: item.title, description: item.description)
        }
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(24)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureFooterSection() {
        let topConstraint = self.contentTopConstraint
        
        let view = UIView()
        
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        
        privacyPolicyButton.text = viewModel.privacyPolicyAction
        termsOfServiceButton.text = viewModel.termsOfServiceAction
        restoreButton.text = viewModel.restoreAction
        
        stackView.addArrangedSubview(privacyPolicyButton)
        stackView.addArrangedSubview(termsOfServiceButton)
        stackView.addArrangedSubview(restoreButton)
        
        let leftSeparatorContainerView = UIView()
        let leftSeparatorView = UIView()
        leftSeparatorView.backgroundColor = colorAppearance.secondaryLabel
        leftSeparatorContainerView.addSubview(leftSeparatorView)
        
        let rightSeparatorContainerView = UIView()
        let rightSeparatorView = UIView()
        rightSeparatorView.backgroundColor = colorAppearance.secondaryLabel
        rightSeparatorContainerView.addSubview(rightSeparatorView)
        
        stackView.addSubview(leftSeparatorContainerView)
        stackView.addSubview(rightSeparatorContainerView)
        
        leftSeparatorView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(13)
        }
        
        rightSeparatorView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(13)
        }
        
        leftSeparatorContainerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.equalTo(privacyPolicyButton.snp.right)
            make.right.equalTo(termsOfServiceButton.snp.left)
        }
        
        rightSeparatorContainerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.equalTo(termsOfServiceButton.snp.right)
            make.right.equalTo(restoreButton.snp.left)
        }
        
        view.addSubview(stackView)
        
        contentView.addSubview(view)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(48)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureStubSection() {
        let topConstraint = self.contentTopConstraint
        
        let view = UIView()
        
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(topConstraint).offset(0)
            make.bottom.equalToSuperview()
        }
    }
    
    private func configureBottomActionsSection() {
        let contentView: UIView = {
            let view = UIView()
            
            view.addSubview(connectButton)
            
            connectButton.snp.makeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.top.equalToSuperview().offset(12)
                make.bottom.equalToSuperview().offset(-16)
            }
            
            return view
        }()
        
        let containerView: UIView = {
            let view = UIView()
            view.backgroundColor = colorAppearance.systemBackground
            
            let separatorView: UIView = {
                let view = UIView()
                view.backgroundColor = colorAppearance.separator.withAlphaComponent(0.12)
                return view
            }()
            
            view.addSubview(separatorView)
            view.addSubview(contentView)
            
            separatorView.snp.makeConstraints { make in
                make.height.equalTo(0.5)
                make.top.equalToSuperview()
                make.horizontalEdges.equalToSuperview()
            }
            
            contentView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.setupSectionHorizontalLayout(traitCollection)
            }
            
            return view
        }()
        
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
        if let item = viewModel.product.selectedItemId.flatMap({ id in viewModel.product.items.first(where: { $0.id == id }) }) {
            connectButton.text = item.action
        }
    }
    
    private func appendHeader(_ text: String) {
        let topConstraint = self.contentTopConstraint
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = colorAppearance.label
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = text
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(topConstraint).offset(48)
        }
    }
    
    private func makePregressSection(_ viewModel: PaywallViewModel.ProductItemViewModel.Item) -> UIView? {
        guard let items = viewModel.descriptionItems, items.count > 0 else {
            return nil
        }
        
        var label: UILabel?
        
        if let text = viewModel.descriptionHeader {
            label = UILabel()
            label?.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            label?.textColor = colorAppearance.label
            label?.textAlignment = .center
            label?.lineBreakMode = .byWordWrapping
            label?.numberOfLines = 0
            label?.text = text
        }
        
        let view = ProgressSectionView()
        
        view.accentColor = colorAppearance.accent
        view.invertAccentColor = colorAppearance.accentLabel
        view.titleTextColor = colorAppearance.label
        view.subTitleTextColor = colorAppearance.secondaryLabel
        
        for (index, item) in items.enumerated() {
            view.append(
                title: item.title,
                subTitle: item.subTitle,
                image: item.icon,
                progress: index == 0 ? 0.3 : (index == items.count - 1 ? nil : 0)
            )
        }
        
        let containerView = UIView()
        
        if let label = label {
            containerView.addSubview(label)
            label.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(48)
                make.directionalHorizontalEdges.equalToSuperview()
            }
        }
        containerView.addSubview(view)
        
        if let label = label {
            view.snp.makeConstraints { make in
                make.top.equalTo(label.snp.bottom).offset(24)
                make.horizontalEdges.bottom.equalToSuperview()
            }
        } else {
            view.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.horizontalEdges.bottom.equalToSuperview()
            }
        }
        
        return containerView
    }
}

extension PaywallViewController {
    
    @objc private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapPrivacyPolicyButton() {
        delegate?.didTapPrivacyPolicy()
    }
    
    @objc private func didTapTermsOfServiceButton() {
        delegate?.didTapTermsOfService()
    }
    
    @objc private func didTapRestoreButton() {
        delegate?.didTapRestore()
    }
    
    @objc private func didTapConnectButton() {
        delegate?.didTapConnect(productWithId: "")
    }
    
    private func didChangeProduct(_ id: String) {
        guard let item = viewModel.product.items.first(where: { $0.id == id }) else {
            return
        }
        
        connectButton.text = item.action
        
        progressSectionContainerView.subviews.forEach({
            $0.removeFromSuperview()
        })
        
        if let view = makePregressSection(item) {
            progressSectionContainerView.addSubview(view)
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func didTapConnectProduct(_ id: String) {
        delegate?.didTapConnect(productWithId: id)
    }
}

extension PaywallViewController: PaywallViewControllerProtocol {
    
    public func showCloseButton(animated: Bool) {
        navigationItem.setRightBarButton(UIBarButtonItem(customView: closeBarButton), animated: animated)
    }
    
    public func showConnectIndication() {
        closeBarButton.isEnabled = false
        privacyPolicyButton.isEnabled = false
        termsOfServiceButton.isEnabled = false
        restoreButton.isEnabled = false
        productsSectionView.isEnabled = false
        
        connectButton.showIndication()
    }
    
    public func hideConnectIndication() {
        closeBarButton.isEnabled = true
        privacyPolicyButton.isEnabled = true
        termsOfServiceButton.isEnabled = true
        restoreButton.isEnabled = true
        productsSectionView.isEnabled = true
        
        connectButton.hideIndication()
    }
    
    public func showRestoreIndication() {
        closeBarButton.isEnabled = false
        privacyPolicyButton.isEnabled = false
        termsOfServiceButton.isEnabled = false
        productsSectionView.isEnabled = false
        
        restoreButton.showIndication()
    }
    
    public func hideRestoreIndication() {
        closeBarButton.isEnabled = true
        privacyPolicyButton.isEnabled = true
        termsOfServiceButton.isEnabled = true
        productsSectionView.isEnabled = true
        
        restoreButton.hideIndication()
    }
}
