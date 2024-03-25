//
// Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit
import QuickToolKit

open class SheetPaywallViewController: UIViewController {
    
    weak open var delegate: SheetPaywallViewControllerDelegate?
    
    private let appearance: SheetPaywallViewControllerAppearance
    
    private let viewModel: PaywallDefaultViewModel
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delaysContentTouches = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1, weight: .bold)
        label.textColor = appearance.labelColor
        return label
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    private lazy var bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private lazy var connectButton: SimpleTextButton = {
        let button = SimpleTextButton()
        button.backgroundContentColor = appearance.accentColor
        button.textColor = UIColor.white
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addAction { [weak self] in
            if let index = self?.topProductSectionView.selectedItemIndex,
               let id = self?.viewModel.products.items[index].id {
                self?.delegate?.didTapConnect(productWithId: id)
            }
        }
        return button
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitleColor(appearance.secondaryLabelColor, for: .normal)
        button.setTitleColor(appearance.secondaryLabelColor.withAlphaComponent(0.5), for: .disabled)
        button.setTitleColor(appearance.secondaryLabelColor.withAlphaComponent(0.7), for: .highlighted)
        button.contentEdgeInsets = UIEdgeInsets(top: 9, left: 8, bottom: 9, right: 8)
        button.setTitle(viewModel.privacyPolicyText, for: .normal)
        button.addAction { [unowned self] in
            self.delegate?.didTapPrivacyPolicy()
        }
        return button
    }()
    
    private lazy var bottomButtonsContainer = UIView()
    
    private lazy var bottomButtonsBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.opaqueSeparator
        return view
    }()
    
    private lazy var termsOfServiceButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byCharWrapping
        button.setTitleColor(appearance.secondaryLabelColor, for: .normal)
        button.setTitleColor(appearance.secondaryLabelColor.withAlphaComponent(0.5), for: .disabled)
        button.setTitleColor(appearance.secondaryLabelColor.withAlphaComponent(0.7), for: .highlighted)
        button.contentEdgeInsets = UIEdgeInsets(top: 9, left: 8, bottom: 9, right: 8)
        button.setTitle(viewModel.termsOfServiceText, for: .normal)
        button.addAction { [unowned self] in
            self.delegate?.didTapTermsOfService()
        }
        return button
    }()
    
    private lazy var topProductSectionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = UIColor.blue
        return label
    }()
    
    private lazy var topProductSectionView: ProductSectionView = {
        let view = ProductSectionView()
        view.didSelectItem = { [weak self] (index) in
            self?.bottomProductSectionView.selectedItemIndex = index
            self?.didSelectProduct(index, false)
        }
        return view
    }()
    
    private lazy var bottomProductSectionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.textColor = UIColor.blue
        return label
    }()
    
    private lazy var bottomProductSectionView: ProductSectionView = {
        let view = ProductSectionView()
        view.didSelectItem = { [weak self] (index) in
            self?.topProductSectionView.selectedItemIndex = index
            self?.didSelectProduct(index, true)
        }
        return view
    }()
    
    private lazy var featureSectionView: FeatureSectionView = {
        let view = FeatureSectionView()
        view.iconColor = appearance.accentColor
        view.textColor = appearance.labelColor
        return view
    }()
    
    private lazy var stepSectionView: StepsSectionView = {
        let view = StepsSectionView()
        view.titleTextColor = appearance.labelColor
        view.itemIconColor = appearance.accentColor
        view.itemTitleTextColor = appearance.labelColor
        view.itemSubTitleTextColor = appearance.secondaryLabelColor
        return view
    }()
    
    private lazy var compareSectionView: CompareSectionView = {
        let view = CompareSectionView()
        view.titleTextColor = appearance.labelColor
        view.subTitleTextColor = appearance.accentColor
        view.detailsTextColor = appearance.labelColor
        view.checkedColor = appearance.compareCheckedColor
        view.uncheckedColor = appearance.compareUncheckedColor
        view.contentBackgroundColor = appearance.compareBackgroundColor
        return view
    }()
    
    private lazy var reviewSectionView: ReviewSectionView = {
        let view = ReviewSectionView()
        view.titleTextColor = appearance.labelColor
        view.itemTitleTextColor = appearance.reviewTitleLabelColor
        view.itemSubTitleTextColor = appearance.reviewSubTitleLabelColor
        view.itemDetailsTextColor = appearance.reviewDetailsLabelColor
        view.itemBackgroundColor = appearance.reviewBackgroundColor
        return view
    }()
    
    private lazy var questionSectionView: QuestionSectionView = {
        let view = QuestionSectionView()
        view.titleTextColor = appearance.labelColor
        view.questionTextColor = appearance.labelColor
        view.answerTextColor = appearance.secondaryLabelColor
        return view
    }()
    
    private lazy var tipSectionView: TipSectionView = {
        let view = TipSectionView()
        view.titleTextColor = appearance.labelColor
        return view
    }()
    
    // MARK: Apperance
    
    public init(appearance: SheetPaywallViewControllerAppearance, viewModel: PaywallDefaultViewModel) {
        self.appearance = appearance
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUI()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: footerView.frame.height - footerView.safeAreaInsets.bottom,
            right: 0
        )
        scrollView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: footerView.frame.height,
            right: 0
        )
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        
        bottomButtonsContainer.addSubview(termsOfServiceButton)
        bottomButtonsContainer.addSubview(privacyPolicyButton)
        bottomButtonsContainer.addSubview(bottomButtonsBorderView)
        
        footerView.addSubview(connectButton)
        footerView.addSubview(bottomButtonsContainer)
        footerView.addSubview(bottomBorderView)
        
        contentView.addSubview(contentStackView)
        
        scrollView.addSubview(contentView)
        scrollView.addSubview(footerView)
        
        view.addSubview(scrollView)
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            if view.traitCollection.horizontalSizeClass == .regular {
                make.width.equalTo(682).priority(.high)
                make.centerX.equalToSuperview()
                make.left.greaterThanOrEqualToSuperview().inset(16).priority(.required)
                make.right.lessThanOrEqualToSuperview().inset(16).priority(.required)
            } else {
                make.horizontalEdges.equalToSuperview().inset(16)
            }
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(.low)
            make.width.equalToSuperview()
        }
        
        termsOfServiceButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(bottomButtonsContainer.snp.centerX)
        }
        
        privacyPolicyButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalTo(bottomButtonsContainer.snp.centerX)
            make.right.equalToSuperview()
        }
        
        bottomButtonsBorderView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.bottom.equalToSuperview().inset(9)
            make.centerX.equalToSuperview()
        }
        
        connectButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalToSuperview().inset(16)
            
            if view.traitCollection.horizontalSizeClass == .regular {
                make.width.equalTo(682).priority(.high)
                make.centerX.equalToSuperview()
                make.left.greaterThanOrEqualToSuperview().inset(16).priority(.required)
                make.right.lessThanOrEqualToSuperview().inset(16).priority(.required)
            } else {
                make.horizontalEdges.equalToSuperview().inset(16)
            }
        }
        
        bottomButtonsContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(connectButton.snp.bottom).offset(8)
            make.bottom.equalTo(footerView.safeAreaLayoutGuide.snp.bottom)
        }
        
        bottomBorderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
        }
        
        footerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }
    
    private func configureUI() {
        titleLabel.attributedText = makeTitle(viewModel.title)
        
        // Products
        let itemModels = viewModel.products.items.map({ (item) in
            return ProductSectionView.CollectionViewCellModel(
                titleText: item.title,
                descriptionText: item.description,
                badge: item.badge.flatMap({ (badge) in
                    return ProductSectionView.CollectionViewCellModel.Badge(
                        text: badge.text,
                        color: badge.color,
                        textColor: badge.textColor
                    )
                })
            )
        })
        
        topProductSectionView.items = itemModels
        bottomProductSectionView.items = itemModels
        
        if let index = viewModel.products.items.firstIndex(where: { $0.id == viewModel.products.selectedItemId }) {
            topProductSectionView.selectedItemIndex = index
            bottomProductSectionView.selectedItemIndex = index
            let item = viewModel.products.items[index]
            topProductSectionLabel.text = item.details
            bottomProductSectionLabel.text = item.details
            connectButton.text = item.actionText
            
            if item.steps.count > 0 {
                stepSectionView.titleText = item.stepsText
                stepSectionView.items = item.steps.enumerated().map({
                    let icon: StepsSectionView.ItemIcon
                    switch $0 {
                    case 0:
                        icon = .bolt
                    case 1:
                        icon = .bell
                    default:
                        icon = .starOfLife
                    }
                    return StepsSectionView.Item(
                        icon: icon,
                        titleText: $1.title,
                        subTitleText: $1.subTitle
                    )
                })
                stepSectionView.isHidden = false
            } else {
                stepSectionView.titleText = nil
                stepSectionView.items = []
                stepSectionView.isHidden = true
            }
            tipSectionView.text = item.disclamer
        }
        
        // Benefits
        featureSectionView.items = viewModel.benefits.items.map({
            let icon: FeatureSectionView.ItemIcon
            switch $0.icon {
            case .clients:
                icon = .clients
            case .documents:
                icon = .documents
            case .reminders:
                icon = .reminders
            case .reports:
                icon = .reports
            case .restrictions:
                icon = .restrictions
            }
            
            return FeatureSectionView.Item(icon: icon, text: $0.titleText)
        })
        
        // Question
        questionSectionView.titleText = viewModel.questions.title
        questionSectionView.items = viewModel.questions.items.map({
            QuestionSectionView.Item(questionText: $0.questionText, answerText: $0.answerText)
        })
        
        // Review
        reviewSectionView.titleText = viewModel.reviews.title
        reviewSectionView.items = viewModel.reviews.items.map({
            ReviewSectionView.Item(nameText: $0.name, subjectText: $0.subject, bodyText: $0.body)
        })
        
        // Feature
        compareSectionView.titleText = viewModel.feature.title
        compareSectionView.headerText = viewModel.feature.name
        compareSectionView.firstOptionText = viewModel.feature.negative
        compareSectionView.secondOptionText = viewModel.feature.positive
        compareSectionView.items = viewModel.feature.items.map({
            $0.name
        })
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(featureSectionView)
        contentStackView.addArrangedSubview(topProductSectionLabel)
        contentStackView.addArrangedSubview(topProductSectionView)
        contentStackView.addArrangedSubview(stepSectionView)
        contentStackView.addArrangedSubview(compareSectionView)
        contentStackView.addArrangedSubview(reviewSectionView)
        contentStackView.addArrangedSubview(questionSectionView)
        contentStackView.addArrangedSubview(bottomProductSectionLabel)
        contentStackView.addArrangedSubview(bottomProductSectionView)
        contentStackView.addArrangedSubview(tipSectionView)
        
        contentStackView.setCustomSpacing(32, after: titleLabel)
        contentStackView.setCustomSpacing(16, after: topProductSectionLabel)
        contentStackView.setCustomSpacing(16, after: bottomProductSectionLabel)
        contentStackView.setCustomSpacing(0, after: bottomProductSectionView)
    }
    
    private func didSelectProduct(_ index: Int, _ fixOffset: Bool) {
        let startOffsetY = scrollView.contentOffset.y
        let startSizeHeight = scrollView.contentSize.height
        
        let item = viewModel.products.items[index]
        topProductSectionLabel.text = item.details
        bottomProductSectionLabel.text = item.details
        if item.steps.count > 0 {
            stepSectionView.titleText = item.stepsText
            stepSectionView.items = item.steps.enumerated().map({
                let icon: StepsSectionView.ItemIcon
                switch $0 {
                case 0:
                    icon = .bolt
                case 1:
                    icon = .bell
                default:
                    icon = .starOfLife
                }
                return StepsSectionView.Item(
                    icon: icon,
                    titleText: $1.title,
                    subTitleText: $1.subTitle
                )
            })
            stepSectionView.isHidden = false
        } else {
            stepSectionView.titleText = nil
            stepSectionView.items = []
            stepSectionView.isHidden = true
        }
        connectButton.text = item.actionText
        tipSectionView.text = item.disclamer
        
        scrollView.layoutIfNeeded()
        
        if fixOffset {
            let newOffsetY = startOffsetY + (scrollView.contentSize.height - startSizeHeight)
            scrollView.setContentOffset(CGPoint(x: 0, y: newOffsetY), animated: false)
        }
    }
    
    private func makeTitle(_ text: String) -> NSAttributedString {
        let mutableString = NSMutableAttributedString()
        var startIndex: Int?
        for c in text {
            guard c == "*" else {
                mutableString.append(NSAttributedString(string: "\(c)"))
                continue
            }
            
            if let index = startIndex {
                mutableString.addAttribute(
                    .foregroundColor,
                    value: appearance.accentColor,
                    range: NSRange(location: index, length: mutableString.length - index)
                )
                startIndex = nil
            } else {
                startIndex = mutableString.length
            }
        }
        return mutableString
    }
}

extension SheetPaywallViewController: PaywallViewControllerProtocol {
    
    public func showIndication() {
        topProductSectionView.isUserInteractionEnabled = false
        bottomProductSectionView.isUserInteractionEnabled = false
        
        connectButton.isEnabled = false
    }
    
    public func hideIndication() {
        topProductSectionView.isUserInteractionEnabled = true
        bottomProductSectionView.isUserInteractionEnabled = true
        
        connectButton.isEnabled = true
    }
    
    public func showConnectIndication() {
        topProductSectionView.isUserInteractionEnabled = false
        bottomProductSectionView.isUserInteractionEnabled = false
        
        connectButton.showIndication()
    }
    
    public func hideConnectIndication() {
        topProductSectionView.isUserInteractionEnabled = true
        bottomProductSectionView.isUserInteractionEnabled = true
        
        connectButton.hideIndication()
    }
}
