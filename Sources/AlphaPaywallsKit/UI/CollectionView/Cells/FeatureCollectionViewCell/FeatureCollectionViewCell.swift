//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class FeatureCollectionViewCell: UICollectionViewCell {
    
    var primaryLabelColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = primaryLabelColor
        }
    }
    
    var horizontalOffset: CGFloat = 0 {
        didSet {
            iconImageContainerView.snp.updateConstraints { make in
                make.left.equalToSuperview().offset(horizontalOffset)
            }
        }
    }
    
    var iconImage: UIImage? {
        didSet {
            iconImageView.image = iconImage
        }
    }
    
    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: iconImage)
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var iconImageContainerView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = primaryLabelColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleText = nil
    }
    
    private func setupUI() {
        iconImageContainerView.addSubview(iconImageView)
        contentView.addSubview(iconImageContainerView)
        contentView.addSubview(titleLabel)
        
        iconImageContainerView.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.left.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.right.lessThanOrEqualToSuperview()
        }
    }
}

extension FeatureCollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? FeatureCollectionViewCellModel else {
            return
        }
        
        titleText = model.text
        iconImage = model.icon
    }
}

extension FeatureCollectionViewCell {
    
    class func calculateWidth(text: String) -> CGFloat {
        let myText = text as NSString
        let rect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(
            with: rect,
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.preferredFont(forTextStyle: .headline, weight: .semibold)],
            context: nil
        )
        return 56 + labelSize.width
    }
}
