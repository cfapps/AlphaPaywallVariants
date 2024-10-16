//
// Copyright © 2024 Alpha Apps LLC. All rights reserved.
//

import UIKit
import SnapKit
import Lottie
import SharedKit
import PaywallsKit

open class PaywallViewController: UIViewController {
    
    private let viewModel: PaywallViewModel
    
    private let colorAppearance: ColorAppearance
    
    private var selectedProductId: String?
    
    private lazy var nameBadgeView: BadgeView = {
        let view = BadgeView(colorAppearance: colorAppearance)
        
        return view
    }()
    
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
        scrollView.delegate = self
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
        
        view.itemBackgroundColor = colorAppearance.tertiarySystemBackground
        view.itemBorderColor = colorAppearance.separator
        view.itemPrimaryTextColor = colorAppearance.label
        view.itemSecondaryTextColor = colorAppearance.secondaryLabel
        view.accentColor = colorAppearance.accent
        view.invertAccentColor = colorAppearance.accentLabel
        
        view.changeFocusedItemAction = { [weak self] (id) in
            self?.didChangeFocusedProduct(id)
        }
        view.selectItemAction = { [weak self] (id) in
            self?.didTapConnectProduct(id)
        }
        
        return view
    }()
    
    private lazy var progressSectionContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var gradientView: GradientView = {
        return GradientView()
    }()
    
    private var gradientViewTopConstraint: Constraint?
    
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
    
    private func setupUI() {
        view.backgroundColor = colorAppearance.systemBackground
        
        navigationController?.navigationBar.barTintColor = colorAppearance.navigationBarTint
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: nameBadgeView)
        
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
        
        scrollView.insertSubview(gradientView, at: 0)
        
        gradientView.snp.makeConstraints { make in
            self.gradientViewTopConstraint = make.top.equalTo(view.snp.top).constraint
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(540)
        }
    }
    
    private func setupContentView() {
        configureCommonView()
        configureBenefitView()
        configureProductsView()
        configureAwardView()
        configureProgressSection()
        configureReviewView()
        configureFeatureView()
        configureHelpSection()
        configureFooterSection()
        configureStubSection()
    }
    
    private func configureCommonView() {
        func splitText(_ input: String) -> (String, String) {
            let components = input.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
            
            let text1 = components.first.map(String.init) ?? ""
            let text2 = components.count > 1 ? String(components[1]) : ""
            
            return (text1, text2)
        }
        
        let (nameText, badgeText) = splitText(viewModel.name)
        
        nameBadgeView.nameText = nameText
        nameBadgeView.badgeText = badgeText
    }
    
    private func configureBenefitView() {
        let topConstraint = self.contentTopConstraint
        
        let view = BenefitSectionView()
        
        view.pageIndicatorTintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12)
        view.currentPageIndicatorTintColor = colorAppearance.accent
        
        view.titleTextColor = colorAppearance.invertPrimaryLabel
        
        for item in viewModel.benefit.items {
            view.append(title: item.title, animation: item.animation)
        }
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(topConstraint)
            make.height.equalTo(400)
        }
        
        view.reloadItems()
    }
    
    private func configureProductsView() {
        let topConstraint = self.contentTopConstraint
        
        productsSectionView.update(
            items: viewModel.product.items.map({ product in
                ProductsSectionView.ViewModel(
                    id: product.id,
                    titleText: product.title,
                    descriptionText: product.subTitle,
                    badgeText: product.detailsTitle,
                    freeText: product.detailsSubTitle,
                    priceText: product.price,
                    priceDescriptionText: product.priceSubTitle,
                    priceBadgeText: product.priceDescription,
                    durationText: product.priceDuration,
                    actionText: product.action,
                    options: product.options.map({
                        ($0.image, $0.text)
                    })
                )
            }),
            selectedItemId: viewModel.product.selectedItemId
        )
        
        contentView.addSubview(productsSectionView)
        
        productsSectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(topConstraint)
        }
    }
    
    private func configureAwardView() {
        let topConstraint = self.contentTopConstraint
        
        let view = AwardSectionView()
        
        view.contentBackgroundColor = colorAppearance.accent
        view.detailsTextColor = colorAppearance.accentLabel
        
        view.detailsText = viewModel.award.title
        view.image = viewModel.award.icon
        
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
        
        if let view = makeProgressSection(item) {
            progressSectionContainerView.addSubview(view)
            view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func configureReviewView() {
        appendHeader(viewModel.review.header)
        
        let topConstraint = self.contentTopConstraint
        
        let view = ReviewSectionView()
        
        view.itemBackgroundColor = colorAppearance.secondarySystemBackground
        view.itemNameTextColor = colorAppearance.secondaryLabel
        view.itemBodyTextColor = colorAppearance.label
        
        for review in viewModel.review.items {
            view.append(name: review.name, body: review.text, image: review.image)
        }
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(24)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureFeatureView() {
        appendHeader(viewModel.feature.header)
        
        let topConstraint = self.contentTopConstraint
        
        let view = FeatureSectionView()
        
        view.contentBackgroundColor = colorAppearance.secondarySystemBackground
        view.headerTitleTextColor = colorAppearance.secondaryLabel
        view.headerBasicTextColor = colorAppearance.secondaryLabel
        view.headerBasicBackgroundColor = UIColor.clear
        view.headerPremiumTextColor = colorAppearance.secondaryLabel
        view.headerPremiumBackgroundColor = UIColor.clear
        view.itemTextColor = colorAppearance.label
        view.availableOptionImage = UIImage(
            systemName: "checkmark.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 17, weight: .regular))
        )?.withTintColor(UIColor(red: 0.2, green: 0.78, blue: 0.35, alpha: 1), renderingMode: .alwaysOriginal)
        view.unavailableOptionImage = UIImage(
            systemName: "xmark.circle.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 17, weight: .regular))
        )?.withTintColor(UIColor(red: 1, green: 0.23, blue: 0.19, alpha: 1), renderingMode: .alwaysOriginal)
        
        view.headerTitleText = viewModel.feature.title
        view.headerBasicOptionText = viewModel.feature.basic
        view.headerPremiumOptionText = viewModel.feature.premium
        
        for item in viewModel.feature.items {
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
        appendHeader(viewModel.help.header)
        
        let topConstraint = self.contentTopConstraint
        
        let view = HelpSectionView()
        
        view.itemBackgroundColor = colorAppearance.secondarySystemBackground
        view.itemTitleTextColor = colorAppearance.label
        view.itemDescriptionTextColor = colorAppearance.secondaryLabel
        view.chevronCollapsedColor = colorAppearance.secondaryLabel
        view.chevronExpandedColor = colorAppearance.tertiaryLabel
        
        for item in viewModel.help.items {
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
    
    private func makeProgressSection(_ viewModel: PaywallViewModel.ProductItemViewModel.Item) -> UIView? {
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
        view.invertAccentColor = .white //colorAppearance.accentInvertLabel
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

extension PaywallViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        gradientViewTopConstraint?.update(offset: -max((scrollView.safeAreaInsets.top + scrollView.contentInset.top) + scrollView.contentOffset.y, 0))
    }
}

extension PaywallViewController {
    
    @objc private func didTapCloseButton() {
        delegate?.didTapClose()
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
    
    private func didTapConnectButton() {
        guard let id = selectedProductId else { return }
        
        delegate?.didTapConnect(productWithId: id)
    }
    
    private func didChangeFocusedProduct(_ id: String) {
        guard let item = viewModel.product.items.first(where: { $0.id == id }) else {
            return
        }
        
        self.selectedProductId = item.id
        
        progressSectionContainerView.subviews.forEach({
            $0.removeFromSuperview()
        })
        
        if let view = makeProgressSection(item) {
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
        
        productsSectionView.showIndication()
    }
    
    public func hideConnectIndication() {
        closeBarButton.isEnabled = true
        privacyPolicyButton.isEnabled = true
        termsOfServiceButton.isEnabled = true
        restoreButton.isEnabled = true
        
        productsSectionView.hideIndication()
    }
    
    public func showRestoreIndication() {
        closeBarButton.isEnabled = false
        privacyPolicyButton.isEnabled = false
        termsOfServiceButton.isEnabled = false
        productsSectionView.isEnabled = false
        
        restoreButton.isEnabled = false
    }
    
    public func hideRestoreIndication() {
        closeBarButton.isEnabled = true
        privacyPolicyButton.isEnabled = true
        termsOfServiceButton.isEnabled = true
        productsSectionView.isEnabled = true
        
        restoreButton.isEnabled = true
    }
}

private final class GradientView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.sublayers?.first?.frame = self.bounds
    }
    
    private func setupUI() {
        let gradientLayer = CAGradientLayer()
        
        // Устанавливаем цвета градиента
        gradientLayer.colors = [
            UIColor.black.cgColor,
            UIColor(red: 0.03, green: 0.17, blue: 0.31, alpha: 1).cgColor,
            UIColor(red: 0, green: 0.42, blue: 0.87, alpha: 1).cgColor,
            UIColor(red: 0, green: 0.48, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.51, green: 0.68, blue: 0.85, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]
        
        // Устанавливаем точки перехода между цветами (location)
        gradientLayer.locations = [0.00, 0.22, 0.52, 0.74, 0.85, 1.00]
        
        // Устанавливаем центр градиента (center)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
