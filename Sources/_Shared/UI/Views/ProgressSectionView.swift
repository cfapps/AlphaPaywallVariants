//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public final class ProgressSectionView: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    public var accentColor: UIColor = UIColor.tertiarySystemBackground
    
    public var invertAccentColor: UIColor = UIColor.tertiaryLabel
    
    public var titleTextColor: UIColor = UIColor.label
    
    public var subTitleTextColor: UIColor = UIColor.secondaryLabel
    
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
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ProgressSectionView {
    
    public func append(title: String, subTitle: String, image: UIImage?, progress: CGFloat?) {
        stackView.addArrangedSubview({
            let view = ItemView()
            
            view.titleTextColor = titleTextColor
            view.subTitleTextColor = subTitleTextColor
            view.accentColor = accentColor
            view.invertAccentColor = invertAccentColor
            
            view.iconImage = image
            view.titleText = title
            view.subTitleText = subTitle
            view.progress = progress
            
            return view
        }())
    }
}

private final class ItemView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = titleTextColor
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = titleText
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = subTitleTextColor
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = subTitleText
        return label
    }()
    
    private lazy var scaleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = accentColor.withAlphaComponent(0.08)
        return view
    }()
    
    private lazy var fillScaleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = accentColor
        return view
    }()
    
    var titleTextColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var subTitleTextColor: UIColor = UIColor.secondaryLabel {
        didSet {
            subTitleLabel.textColor = subTitleTextColor
        }
    }
    
    var accentColor: UIColor = UIColor.tertiarySystemBackground {
        didSet {
            scaleView.backgroundColor = accentColor.withAlphaComponent(0.08)
            fillScaleView.backgroundColor = accentColor
            updateImageColors()
        }
    }
    
    var invertAccentColor: UIColor = UIColor.tertiaryLabel {
        didSet {
            updateImageColors()
        }
    }
    
    var iconImage: UIImage? {
        didSet {
            updateImageColors()
        }
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var subTitleText: String? {
        didSet {
            subTitleLabel.text = subTitleText
        }
    }
    
    var progress: CGFloat? {
        didSet {
            if let progress = progress, progress > 0 {
                scaleView.isHidden = false
                fillScaleView.isHidden = false
                fillScaleView.snp.remakeConstraints { make in
                    make.top.equalTo(scaleView)
                    make.horizontalEdges.equalTo(scaleView)
                    make.height.equalTo(scaleView).multipliedBy(min(progress, 1))
                }
            } else if progress != nil {
                scaleView.isHidden = false
                fillScaleView.isHidden = false
                fillScaleView.snp.remakeConstraints { make in
                    make.top.equalTo(scaleView)
                    make.horizontalEdges.equalTo(scaleView)
                    make.height.equalTo(scaleView).multipliedBy(0)
                }
            } else {
                scaleView.isHidden = true
                fillScaleView.isHidden = true
            }
            
            updateImageColors()
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
        let imageContainerView = {
            let view = UIView()
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            return view
        }()
        
        imageContainerView.addSubview(imageView)
        
        addSubview(imageContainerView)
        
        imageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(imageContainerView.snp.right).offset(16)
            make.right.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
            make.left.equalTo(imageContainerView.snp.right).offset(16)
            make.right.equalToSuperview()
        }
        
        addSubview(scaleView)
        addSubview(fillScaleView)
        
        scaleView.snp.makeConstraints { make in
            make.top.equalTo(imageContainerView.snp.bottom).offset(2)
            make.bottom.equalToSuperview().offset(-2)
            make.width.equalTo(4)
            make.centerX.equalTo(imageContainerView.snp.centerX)
        }
        
        fillScaleView.snp.makeConstraints { make in
            make.top.equalTo(scaleView)
            make.horizontalEdges.equalTo(scaleView)
            make.height.equalTo(scaleView).multipliedBy(0.2)
        }
    }
    
    private func updateImageColors() {
        if let progress = progress, progress > 0 {
            imageView.superview?.backgroundColor = accentColor
            imageView.image = iconImage?.withTintColor(invertAccentColor, renderingMode: .alwaysOriginal)
        } else if progress != nil {
            imageView.superview?.backgroundColor = accentColor.withAlphaComponent(0.08)
            imageView.image = iconImage?.withTintColor(accentColor, renderingMode: .alwaysOriginal)
        } else {
            imageView.superview?.backgroundColor = accentColor.withAlphaComponent(0.08)
            imageView.image = iconImage?.withTintColor(accentColor, renderingMode: .alwaysOriginal)
        }
    }
}
