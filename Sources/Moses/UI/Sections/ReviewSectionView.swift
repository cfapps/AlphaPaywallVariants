//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public final class ReviewSectionView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    public var itemBackgroundColor: UIColor = UIColor.secondarySystemFill
    
    public var itemNameTextColor: UIColor = UIColor.label
    
    public var itemTitleTextColor: UIColor = UIColor.label
    
    public var itemBodyTextColor: UIColor = UIColor.label
    
    public init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ReviewSectionView {
    
    public func append(name: String, title: String, body: String, image: UIImage?) {
        stackView.addArrangedSubview({
            let view = ItemView()
            
            view.contentBackgroundColor = itemBackgroundColor
            view.nameTextColor = itemNameTextColor
            view.titleTextColor = itemTitleTextColor
            view.bodyTextColor = itemBodyTextColor
            
            view.nameText = name
            view.titleText = title
            view.bodyText = body
            view.iconImage = image
            
            return view
        }())
    }
}

private final class ItemView: UIView {
    
    private lazy var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = contentBackgroundColor
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var containerImageView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var rateStackView: UIStackView = {
        func makeRateImageView() -> UIView {
            let containerView: UIView = {
                let view = UIView()
                return view
            }()
            
            let imageView = UIImageView(
                image: UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(
                    UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 16.5, weight: .regular))
                )?.withTintColor(UIColor(red: 1, green: 0.8, blue: 0, alpha: 1), renderingMode: .alwaysOriginal)
            )
            
            containerView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
                make.center.equalToSuperview()
            }
            
            containerView.snp.makeConstraints { make in
                make.width.height.equalTo(20)
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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = nameTextColor
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = titleTextColor
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = bodyTextColor
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var contentBackgroundColor: UIColor = UIColor.quaternarySystemFill {
        didSet {
            contentContainerView.backgroundColor = contentBackgroundColor
        }
    }
    
    var nameTextColor: UIColor = UIColor.secondaryLabel {
        didSet {
            nameLabel.textColor = nameTextColor
        }
    }
    
    var titleTextColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = bodyTextColor
        }
    }
    
    var bodyTextColor: UIColor = UIColor.label {
        didSet {
            bodyLabel.textColor = bodyTextColor
        }
    }
    
    var iconImage: UIImage? {
        didSet {
            imageView.image = iconImage
        }
    }
    
    var nameText: String? {
        didSet{
            nameLabel.text = nameText
        }
    }
    
    var titleText: String? {
        didSet{
            titleLabel.text = titleText
        }
    }
    
    var bodyText: String? {
        didSet{
            bodyLabel.text = bodyText
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(contentContainerView)
        
        contentContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerImageView.addSubview(imageView)
        
        contentContainerView.addSubview(containerImageView)
        
        imageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
        
        containerImageView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(12)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
        }
        
        contentContainerView.addSubview(rateStackView)
        
        rateStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalTo(containerImageView.snp.right).offset(12)
            make.right.lessThanOrEqualToSuperview().offset(-12)
        }
        
        contentContainerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(14)
            make.centerY.equalTo(rateStackView)
        }
        
        let textContainerView = UIView()
        
        textContainerView.addSubview(titleLabel)
        textContainerView.addSubview(bodyLabel)
        
        contentContainerView.addSubview(textContainerView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        textContainerView.snp.makeConstraints { make in
            make.top.equalTo(rateStackView.snp.bottom).offset(2)
            make.bottom.lessThanOrEqualToSuperview().offset(-12)
            make.right.equalToSuperview().inset(12)
            make.left.equalTo(containerImageView.snp.right).offset(12)
        }
    }
}
