//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public final class AwardSectionView: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = contentBackgroundColor
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = detailsTextColor
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private lazy var imageContainerView = UIView()
    
    public var contentBackgroundColor: UIColor = UIColor.secondarySystemBackground {
        didSet {
            contentView.backgroundColor = contentBackgroundColor
        }
    }
    
    public var detailsTextColor: UIColor = UIColor.label {
        didSet {
            detailsLabel.textColor = detailsTextColor
        }
    }
    
    public var detailsText: String? {
        didSet {
            detailsLabel.text = detailsText
        }
    }
    
    public var image: UIImage? {
        didSet {
            imageView.image = image
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
        addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageContainerView.addSubview(imageView)
        
        contentView.addSubview(detailsLabel)
        contentView.addSubview(imageContainerView)
        
        detailsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
        }
        
        imageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(32)
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
        }
    }
}
