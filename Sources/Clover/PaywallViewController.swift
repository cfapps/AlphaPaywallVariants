//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SnapKit
import SharedKit
import PaywallsKit

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
        button.contentInsets = UIEdgeInsets(top: 11, left: 8, bottom: 11, right: 8)
        button.textFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.textColor = colorAppearance.secondaryLabel
        button.addTarget(self, action: #selector(didTapPrivacyPolicyButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var termsOfServiceButton: TextButton = {
        let button = TextButton()
        button.contentInsets = UIEdgeInsets(top: 11, left: 8, bottom: 11, right: 8)
        button.textFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.textColor = colorAppearance.secondaryLabel
        button.addTarget(self, action: #selector(didTapTermsOfServiceButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var restoreButton: TextButton = {
        let button = TextButton()
        button.contentInsets = UIEdgeInsets(top: 11, left: 8, bottom: 11, right: 8)
        button.textFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.textColor = colorAppearance.label
        button.addTarget(self, action: #selector(didTapRestoreButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "doc.transform.fill", in: Bundle.module, with: nil)
        imageView.layer.compositingFilter = "multiplyBlendMode"
        return imageView
    }()
    
    private lazy var bottomActionsView: BottomActionsSectionView = {
        let view = BottomActionsSectionView()
        return view
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
        
        let bottomInset = bottomActionsView.frame.height
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
        
        //        let backgroundImageContainerView = UIView()
        //        backgroundImageContainerView.addSubview(backgroundImageView)
        //        contentView.addSubview(backgroundImageContainerView)
        //        backgroundImageView.snp.makeConstraints { make in
        //            make.top.equalToSuperview()
        //            make.bottom.lessThanOrEqualToSuperview()
        //            make.height.equalTo(500)
        //            make.width.equalToSuperview()
        //        }
        //        backgroundImageContainerView.snp.makeConstraints { make in
        //            make.top.equalToSuperview()
        //            make.width.equalTo(contentView)
        //        }
        
        setupContentView()
    }
    
    private func setupContentView() {
        configureHeaderSection()
        configureBadgeSection()
        configureBenefitSection()
        configureDetailsSection()
        configureAwardView()
        configureReviewView()
        configureFeatureView()
        configureHelpSection()
        configureFooterSection()
        configureStubSection()
        configureBottomActionsSection()
    }
    
    private func configureHeaderSection() {
        let view = UIView()
        
        let rateStackView: UIStackView = {
            let image = UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(
                UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 23.57, weight: .regular))
            )?.withTintColor(UIColor(red: 1, green: 0.8, blue: 0, alpha: 1), renderingMode: .alwaysOriginal)
            func makeRateImageView() -> UIView {
                let containerView: UIView = {
                    let view = UIView()
                    return view
                }()
                
                let imageView = UIImageView(image: image)
                
                containerView.addSubview(imageView)
                imageView.snp.makeConstraints { make in
                    make.top.greaterThanOrEqualToSuperview()
                    make.bottom.lessThanOrEqualToSuperview()
                    make.left.greaterThanOrEqualToSuperview()
                    make.right.lessThanOrEqualToSuperview()
                    make.center.equalToSuperview()
                }
                
                containerView.snp.makeConstraints { make in
                    make.width.height.equalTo(32)
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
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
            label.textColor = colorAppearance.label
            label.textAlignment = .left
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            return label
        }()
        
        view.addSubview(rateStackView)
        view.addSubview(titleLabel)
        
        rateStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(rateStackView.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        titleLabel.text = viewModel.title
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureBadgeSection() {
        let topConstraint = self.contentTopConstraint
        
        let view = BadgeSectionView()
        
        view.itemTextColor = colorAppearance.label
        view.itemBackgroundColor = colorAppearance.secondarySystemBackground
        
        for text in viewModel.options {
            view.append(body: text)
        }
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(24)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureBenefitSection() {
        let topConstraint = self.contentTopConstraint
        
        let view = BenefitSectionView()
        
        view.itemTextColor = colorAppearance.label
        
        for text in viewModel.benefits {
            view.append(text: text)
        }
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(24)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureDetailsSection() {
        let topConstraint = self.contentTopConstraint
        
        let view = DetailsSectionView()
        
        view.titleTextColor = colorAppearance.label
        view.subTitleTextColor = colorAppearance.secondaryLabel
        
        view.titleText = viewModel.detailsText
        view.subTitleText = viewModel.subDetailsText
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(24)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureAwardView() {
        appendHeader(viewModel.award.header)
        
        let topConstraint = self.contentTopConstraint
        
        let view = AwardSectionView()
        
        view.detailsTextColor = colorAppearance.label
        
        view.detailsText = viewModel.award.title
        view.image = viewModel.award.icon
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(topConstraint).offset(24)
            make.setupSectionHorizontalLayout(traitCollection)
        }
    }
    
    private func configureReviewView() {
        let topConstraint = self.contentTopConstraint
        
        let view = ReviewSectionView()
        
        view.itemBackgroundColor = colorAppearance.secondarySystemBackground
        view.itemTextColor = colorAppearance.label
        
        for text in viewModel.reviews {
            view.append(body: text)
        }
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(topConstraint).offset(48)
        }
    }
    
    private func configureFeatureView() {
        appendHeader(viewModel.feature.header)
        
        let topConstraint = self.contentTopConstraint
        
        let view = FeatureSectionView()
        
        view.contentBackgroundColor = colorAppearance.secondarySystemBackground
        view.headerTitleTextColor = colorAppearance.label
        view.headerBasicTextColor = colorAppearance.secondaryLabel
        view.headerBasicBackgroundColor = UIColor.clear
        view.headerPremiumTextColor = colorAppearance.label
        view.headerPremiumBackgroundColor = colorAppearance.featurePremiumBadgeFill
        view.itemTextColor = colorAppearance.label
        view.availableOptionImage = UIImage(
            systemName: "checkmark",
            withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 17, weight: .regular))
        )?.withTintColor(colorAppearance.label, renderingMode: .alwaysOriginal)
        view.unavailableOptionImage = UIImage(
            systemName: "lock.fill",
            withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 17, weight: .regular))
        )?.withTintColor(colorAppearance.tertiaryLabel, renderingMode: .alwaysOriginal)
        
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
        view.itemDescriptionTextColor = colorAppearance.label
        view.chevronCollapsedColor = colorAppearance.tertiaryLabel
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
        stackView.distribution = .fillEqually
        
        privacyPolicyButton.text = viewModel.privacyPolicyAction
        termsOfServiceButton.text = viewModel.termsOfServiceAction
        restoreButton.text = viewModel.restoreAction
        
        stackView.addArrangedSubview(termsOfServiceButton)
        stackView.addArrangedSubview(privacyPolicyButton)
        
        let separatorView = UIView()
        separatorView.backgroundColor = colorAppearance.secondaryLabel
        
        stackView.addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
            make.verticalEdges.equalToSuperview().inset(13)
        }
        
        view.addSubview(stackView)
        view.addSubview(restoreButton)
        
        contentView.addSubview(view)
        
        restoreButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.top.equalTo(stackView.snp.bottom).offset(32)
            make.bottom.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
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
        bottomActionsView.primaryButtonTextColor = colorAppearance.primaryButtonLabel
        bottomActionsView.primaryButtonBackgroundColor = colorAppearance.primaryButtonBackground
        bottomActionsView.secondaryButtonTextColor = colorAppearance.label
        
        bottomActionsView.primaryButtonText = viewModel.product.connectActionText
        bottomActionsView.secondaryButtonText = viewModel.productsAction
        
        bottomActionsView.primaryAction = { [weak self] in
            self?.didTapConnectButton()
        }
        bottomActionsView.secondaryAction = { [weak self] in
            self?.didTapAllProductsButton()
        }
        
        bottomActionsView.isAvailableSecondaryButton = true
        
        let containerView: UIView = {
            let view = UIView()
            
            view.backgroundColor = colorAppearance.systemBackground
            
            let separatorView: UIView = {
                let view = UIView()
                view.backgroundColor = colorAppearance.separator.withAlphaComponent(0.12)
                return view
            }()
            
            view.addSubview(separatorView)
            view.addSubview(bottomActionsView)
            
            separatorView.snp.makeConstraints { make in
                make.height.equalTo(0.5)
                make.top.equalToSuperview()
                make.horizontalEdges.equalToSuperview()
            }
            
            bottomActionsView.snp.makeConstraints { make in
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
    }
    
    private func appendHeader(_ text: String) {
        let topConstraint = self.contentTopConstraint
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = colorAppearance.label
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = text
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(topConstraint).offset(64)
        }
    }
}

extension PaywallViewController {
    
    @objc private func didTapCloseButton() {
        delegate?.didTapClose()
    }
    
    @objc private func didTapPrivacyPolicyButton() {
        
    }
    
    @objc private func didTapTermsOfServiceButton() {
        
    }
    
    @objc private func didTapRestoreButton() {
        delegate?.didTapRestore()
    }
    
    private func didTapConnectButton() {
        delegate?.didTapConnect(productWithId: "")
    }
    
    private func didTapAllProductsButton() {
        
    }
}

extension PaywallViewController: PaywallViewControllerProtocol {
    
    public func showCloseButton(animated: Bool) {
        navigationItem.setRightBarButton(UIBarButtonItem(customView: closeBarButton), animated: animated)
    }
    
    public func showConnectIndication() {
        closeBarButton.isEnabled = false
        restoreButton.isEnabled = false
        bottomActionsView.isEnableSecondaryButton = false
        
        bottomActionsView.showIndicationPrimaryButton()
    }
    
    public func hideConnectIndication() {
        closeBarButton.isEnabled = true
        restoreButton.isEnabled = true
        bottomActionsView.isEnableSecondaryButton = true
        
        bottomActionsView.hideIndicationPrimaryButton()
    }
    
    public func showRestoreIndication() {
        closeBarButton.isEnabled = false
        bottomActionsView.isEnablePrimaryButton = false
        bottomActionsView.isEnableSecondaryButton = false
        
        restoreButton.showIndication()
    }
    
    public func hideRestoreIndication() {
        closeBarButton.isEnabled = true
        bottomActionsView.isEnablePrimaryButton = true
        bottomActionsView.isEnableSecondaryButton = true
        
        restoreButton.hideIndication()
    }
}
