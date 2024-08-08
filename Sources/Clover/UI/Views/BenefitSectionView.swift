//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

final class BenefitSectionView: UIView {
    
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
    
    var itemTextColor: UIColor = UIColor.label
    
    init() {
        super.init(frame: CGRect.zero)
        
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
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension BenefitSectionView {
    
    func append(text: String) {
        stackView.addArrangedSubview({
            let view = ItemView()
            
            view.titleTextColor = itemTextColor
            
            view.iconImage = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(itemTextColor, renderingMode: .alwaysOriginal)
            view.titleText = text
            
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
        return label
    }()
    
    var titleTextColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var iconImage: UIImage? {
        didSet {
            imageView.image = iconImage
        }
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
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
        let imageContainerView = UIView()
        
        imageContainerView.addSubview(imageView)
        
        addSubview(imageContainerView)
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.left.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imageContainerView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.greaterThanOrEqualToSuperview().inset(4)
            make.bottom.lessThanOrEqualToSuperview().inset(4)
            make.centerY.equalToSuperview()
        }
    }
}
