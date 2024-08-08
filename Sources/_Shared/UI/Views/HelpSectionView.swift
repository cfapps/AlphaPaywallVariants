//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SnapKit

public final class HelpSectionView: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    public var itemBackgroundColor: UIColor = UIColor.systemGroupedBackground {
        didSet {
            for view in stackView.arrangedSubviews.compactMap({ $0 as? ItemView }) {
                view.backgroundColor = itemBackgroundColor
            }
        }
    }
    
    public var itemTitleTextColor: UIColor = UIColor.label {
        didSet {
            for view in stackView.arrangedSubviews.compactMap({ $0 as? ItemView }) {
                view.titleTextColor = itemTitleTextColor
            }
        }
    }
    
    public var itemDescriptionTextColor: UIColor = UIColor.secondaryLabel {
        didSet {
            for view in stackView.arrangedSubviews.compactMap({ $0 as? ItemView }) {
                view.descriptionTextColor = itemDescriptionTextColor
            }
        }
    }
    
    public var chevronCollapsedColor: UIColor = UIColor.secondaryLabel
    
    public var chevronExpandedColor: UIColor = UIColor.tertiaryLabel
    
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
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HelpSectionView {
    
    public func append(title: String, description: String) {
        stackView.addArrangedSubview({
            let view = ItemView()
            
            view.backgroundColor = itemBackgroundColor
            view.titleTextColor = itemTitleTextColor
            view.descriptionTextColor = itemDescriptionTextColor
            view.chevronCollapsedColor = chevronCollapsedColor
            view.chevronExpandedColor = chevronExpandedColor
            
            view.titleText = title
            view.descriptionText = description
            return view
        }())
    }
}

extension HelpSectionView {
    
    private final class ItemView: UIView {
        
        private lazy var contentView: UIView = {
            let view = UIView()
            return view
        }()
        
        private lazy var collapsedImage = UIImage(named: "chevron.down", in: Bundle.module, with: nil)
        
        private lazy var expandedImage = UIImage(named: "chevron.up", in: Bundle.module, with: nil)
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = collapsedImage?.withTintColor(chevronCollapsedColor, renderingMode: .alwaysOriginal)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = titleFont
            label.textColor = titleTextColor
            label.textAlignment = .left
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.text = titleText
            return label
        }()
        
        private lazy var descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = descriptionFont
            label.textColor = descriptionTextColor
            label.textAlignment = .left
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.text = descriptionText
            return label
        }()
        
        private lazy var titleContainerView = UIView()
        
        private lazy var descriptionContainerView = UIView()
        
        var titleFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .semibold) {
            didSet {
                titleLabel.font = titleFont
            }
        }
        
        var titleTextColor: UIColor = UIColor.label {
            didSet {
                titleLabel.textColor = titleTextColor
            }
        }
        
        var descriptionFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular) {
            didSet {
                descriptionLabel.font = descriptionFont
            }
        }
        
        var descriptionTextColor: UIColor = UIColor.secondaryLabel {
            didSet {
                descriptionLabel.textColor = descriptionTextColor
            }
        }
        
        var titleText: String? {
            didSet {
                titleLabel.text = titleText
            }
        }
        
        var descriptionText: String? {
            didSet {
                descriptionLabel.text = descriptionText
            }
        }
        
        var chevronCollapsedColor: UIColor = UIColor.secondaryLabel {
            didSet {
                updateIcon()
            }
        }
        
        var chevronExpandedColor: UIColor = UIColor.tertiaryLabel {
            didSet {
                updateIcon()
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
            layer.cornerRadius = 16
            layer.masksToBounds = true
            
            let iconImageContainerView: UIView = {
                let view = UIView()
                view.addSubview(iconImageView)
                iconImageView.snp.makeConstraints { make in
                    make.top.greaterThanOrEqualToSuperview()
                    make.bottom.lessThanOrEqualToSuperview()
                    make.left.greaterThanOrEqualToSuperview()
                    make.right.lessThanOrEqualToSuperview()
                    make.center.equalToSuperview()
                }
                return view
            }()
            
            titleContainerView.addSubview(titleLabel)
            titleContainerView.addSubview(iconImageContainerView)
            descriptionContainerView.addSubview(descriptionLabel)
            
            contentView.addSubview(titleContainerView)
            
            addSubview(contentView)
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalTo(iconImageContainerView.snp.left).offset(-16)
            }
            
            iconImageContainerView.snp.makeConstraints { make in
                make.width.height.equalTo(22)
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.directionalHorizontalEdges.equalToSuperview()
            }
            
            titleContainerView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.horizontalEdges.equalToSuperview()
            }
            
            contentView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(16)
                make.bottom.equalToSuperview().offset(-16)
                make.horizontalEdges.equalToSuperview().inset(16)
            }
            
            addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapTitle)))
        }
        
        @objc private func didTapTitle() {
            if descriptionContainerView.superview == nil {
                contentView.addSubview(descriptionContainerView)
                
                titleContainerView.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.horizontalEdges.equalToSuperview()
                }
                
                descriptionContainerView.snp.makeConstraints { make in
                    make.top.equalTo(titleContainerView.snp.bottom).offset(6)
                    make.bottom.equalToSuperview()
                    make.horizontalEdges.equalToSuperview()
                }
                
                iconImageView.image = expandedImage?.withTintColor(chevronExpandedColor, renderingMode: .alwaysOriginal)
            } else {
                descriptionContainerView.removeFromSuperview()
                descriptionContainerView.snp.removeConstraints()
                
                titleContainerView.snp.remakeConstraints { make in
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.horizontalEdges.equalToSuperview()
                }
                
                iconImageView.image = collapsedImage?.withTintColor(chevronCollapsedColor, renderingMode: .alwaysOriginal)
            }
        }
        
        private func updateIcon() {
            if descriptionContainerView.superview == nil {
                iconImageView.image = collapsedImage?.withTintColor(chevronCollapsedColor, renderingMode: .alwaysOriginal)
            } else {
                iconImageView.image = expandedImage?.withTintColor(chevronExpandedColor, renderingMode: .alwaysOriginal)
            }
        }
    }
}
