//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import UIKit
import QuickToolKit

final class StepCollectionViewCell: UICollectionViewCell {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var iconImageContainerView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = titleLabelColor
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = subTitleLabelColor
        return label
    }()
    
    var titleLabelColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = titleLabelColor
        }
    }
    
    var subTitleLabelColor: UIColor = UIColor.secondaryLabel {
        didSet {
            subTitleLabel.textColor = subTitleLabelColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    private func setupUI() {
        backgroundColor = .clear
        
        iconImageContainerView.addSubview(iconImageView)
        
        contentView.addSubview(iconImageContainerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.top.left.greaterThanOrEqualToSuperview()
            make.bottom.right.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
        
        iconImageContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.left.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(iconImageContainerView.snp.trailing)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.bottom.lessThanOrEqualToSuperview()
            make.leading.equalTo(iconImageContainerView.snp.trailing)
            make.trailing.lessThanOrEqualToSuperview()
        }
    }
}

extension StepCollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? StepCollectionViewCellModel else {
            return
        }
        
        iconImageView.image = retreiveImage(model.iconImageName)
        titleLabel.text = model.titleText
        subTitleLabel.text = model.subTitleText
    }
    
    private func retreiveImage(_ name: String) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 26, weight: .semibold))
        var image = UIImage(systemName: name)
        image = image?.applyingSymbolConfiguration(configuration)
        image = image?.withTintColor(UIColor.blue, renderingMode: .alwaysOriginal)
        return image
    }
}
