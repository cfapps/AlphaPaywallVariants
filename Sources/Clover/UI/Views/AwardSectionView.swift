//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

final class AwardSectionView: UIView {
    
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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var detailsTextColor: UIColor = UIColor.label {
        didSet {
            detailsLabel.textColor = detailsTextColor
        }
    }
    
    var detailsText: String? {
        didSet {
            detailsLabel.text = detailsText
        }
    }
    
    var image: UIImage? {
        didSet {
            imageView.image = image
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
        addSubview(detailsLabel)
        
        detailsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        
        addSubview(imageContainerView)
        
        imageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageContainerView.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }
}
