//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public final class FeatureSectionView: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = contentBackgroundColor
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        
        view.titleTextColor = UIColor.white
        
        view.basicTextColor = headerBasicTextColor
        view.basicBackgroundColor = headerPremiumBackgroundColor
        
        view.premiumTextColor = headerPremiumTextColor
        view.premiumBackgroundColor = headerPremiumBackgroundColor
        
        view.titleText = headerTitleText
        
        return view
    }()
    
    public var contentBackgroundColor: UIColor = UIColor.secondarySystemBackground {
        didSet {
            contentView.backgroundColor = contentBackgroundColor
        }
    }
    
    public var headerTitleTextColor: UIColor = UIColor.label {
        didSet {
            headerView.titleTextColor = headerTitleTextColor
        }
    }
    
    public var headerBasicTextColor: UIColor = UIColor.label {
        didSet {
            headerView.basicTextColor = headerBasicTextColor
        }
    }
    
    public var headerBasicBackgroundColor: UIColor = UIColor.clear {
        didSet {
            headerView.basicBackgroundColor = headerBasicBackgroundColor
        }
    }
    
    public var headerPremiumTextColor: UIColor = UIColor.label {
        didSet {
            headerView.premiumTextColor = headerPremiumTextColor
        }
    }
    
    public var headerPremiumBackgroundColor: UIColor = UIColor.clear {
        didSet {
            headerView.premiumBackgroundColor = headerPremiumBackgroundColor
        }
    }
    
    public var itemTextColor: UIColor = UIColor.label
    
    public var availableOptionImage: UIImage?
    
    public var unavailableOptionImage: UIImage?
    
    public var headerTitleText: String? {
        didSet {
            headerView.titleText = headerTitleText
        }
    }
    
    public var headerBasicOptionText: String? {
        didSet {
            headerView.basicOptionText = headerBasicOptionText
        }
    }
    
    public var headerPremiumOptionText: String? {
        didSet {
            headerView.premiumOptionText = headerPremiumOptionText
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(stackView)
        
        addSubview(contentView)
        
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(8)
            make.horizontalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(headerView)
    }
}

extension FeatureSectionView {
    
    public func append(title: String, isAvailableBasic: Bool, isAvailablePremium: Bool) {
        stackView.addArrangedSubview({
            let view = ItemView(isAvailableBasic, isAvailablePremium, headerView.optionWidth)
            
            view.titleTextColor = itemTextColor
            view.availableOptionImage = availableOptionImage
            view.unavailableOptionImage = unavailableOptionImage
            
            view.titleText = title
            
            return view
        }())
    }
}

private final class HeaderView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = titleTextColor
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var basicOptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = basicTextColor
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var basicOptionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = basicBackgroundColor
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var premiumOptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = premiumTextColor
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var premiumOptionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = premiumBackgroundColor
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()
    
    var titleTextColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var basicTextColor: UIColor = UIColor.label {
        didSet {
            basicOptionLabel.textColor = basicTextColor
        }
    }
    
    var premiumTextColor: UIColor = UIColor.label {
        didSet {
            premiumOptionLabel.textColor = premiumTextColor
        }
    }
    
    var basicBackgroundColor: UIColor = UIColor.tertiarySystemGroupedBackground {
        didSet {
            basicOptionContainerView.backgroundColor = basicBackgroundColor
        }
    }
    
    var premiumBackgroundColor: UIColor = UIColor.tertiarySystemGroupedBackground {
        didSet {
            premiumOptionContainerView.backgroundColor = premiumBackgroundColor
        }
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var basicOptionText: String? {
        didSet {
            basicOptionLabel.text = basicOptionText
            updateOptionWidth()
        }
    }
    
    var premiumOptionText: String? {
        didSet {
            premiumOptionLabel.text = premiumOptionText
            updateOptionWidth()
        }
    }
    
    private(set) var optionWidth: CGFloat = 0
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        basicOptionContainerView.addSubview(basicOptionLabel)
        premiumOptionContainerView.addSubview(premiumOptionLabel)
        
        addSubview(titleLabel)
        addSubview(basicOptionContainerView)
        addSubview(premiumOptionContainerView)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(basicOptionContainerView.snp.left).offset(-8)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        basicOptionContainerView.snp.makeConstraints { make in
            make.width.equalTo(56)
            make.left.equalTo(titleLabel.snp.right).offset(8)
            make.right.equalTo(premiumOptionContainerView.snp.left).offset(-8)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        basicOptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2)
            make.bottom.equalToSuperview().inset(2)
            make.leading.greaterThanOrEqualToSuperview().offset(2)
            make.trailing.lessThanOrEqualToSuperview().offset(-2)
            make.centerX.equalToSuperview()
        }
        
        premiumOptionContainerView.snp.makeConstraints { make in
            make.width.equalTo(56)
            make.right.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(12)
        }
        
        premiumOptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2)
            make.bottom.equalToSuperview().inset(2)
            make.leading.greaterThanOrEqualToSuperview().offset(2)
            make.trailing.lessThanOrEqualToSuperview().offset(-2)
            make.centerX.equalToSuperview()
        }
    }
    
    private func updateOptionWidth() {
        func calculateBasicOptionWidth() -> CGFloat {
            return basicOptionLabel.systemLayoutSizeFitting(
                CGSize.zero,
                withHorizontalFittingPriority: .fittingSizeLevel,
                verticalFittingPriority: .fittingSizeLevel
            ).width
        }
        
        func calculatePremiumOptionWidth() -> CGFloat {
            return premiumOptionLabel.systemLayoutSizeFitting(
                CGSize.zero,
                withHorizontalFittingPriority: .fittingSizeLevel,
                verticalFittingPriority: .fittingSizeLevel
            ).width + 4
        }
        
        optionWidth = min(max(calculateBasicOptionWidth(), calculatePremiumOptionWidth(), 56), 96)
        
        basicOptionContainerView.snp.updateConstraints { make in
            make.width.equalTo(optionWidth)
        }
        premiumOptionContainerView.snp.updateConstraints { make in
            make.width.equalTo(optionWidth)
        }
    }
}

private final class ItemView: UIView {
    
    private let isAvailableBasic: Bool
    private let isAvailablePremium: Bool
    private let optionWidth: CGFloat
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = titleTextColor
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var basicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = isAvailableBasic ? availableOptionImage : unavailableOptionImage
        return imageView
    }()
    
    private lazy var premiumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = isAvailablePremium ? availableOptionImage : unavailableOptionImage
        return imageView
    }()
    
    var titleTextColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var availableOptionImage: UIImage? {
        didSet {
            basicImageView.image = isAvailableBasic ? availableOptionImage : unavailableOptionImage
            premiumImageView.image = isAvailablePremium ? availableOptionImage : unavailableOptionImage
        }
    }
    
    var unavailableOptionImage: UIImage? {
        didSet {
            basicImageView.image = isAvailableBasic ? availableOptionImage : unavailableOptionImage
            premiumImageView.image = isAvailablePremium ? availableOptionImage : unavailableOptionImage
        }
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    init(_ isAvailableBasic: Bool, _ isAvailablePremium: Bool, _ optionWidth: CGFloat) {
        self.isAvailableBasic = isAvailableBasic
        self.isAvailablePremium = isAvailablePremium
        self.optionWidth = optionWidth
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let positiveImageContainerView = UIView()
        let negativeImageContainerView = UIView()
        
        positiveImageContainerView.addSubview(basicImageView)
        negativeImageContainerView.addSubview(premiumImageView)
        
        addSubview(titleLabel)
        addSubview(positiveImageContainerView)
        addSubview(negativeImageContainerView)
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(basicImageView.snp.left).offset(-8)
        }
        
        basicImageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
        
        premiumImageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
        
        positiveImageContainerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(optionWidth)
            make.right.equalTo(negativeImageContainerView.snp.left).offset(-8)
        }
        
        negativeImageContainerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(optionWidth)
            make.right.equalToSuperview().inset(16)
        }
    }
}
