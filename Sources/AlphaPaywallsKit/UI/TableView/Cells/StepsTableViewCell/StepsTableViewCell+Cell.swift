//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

extension StepsTableViewCell {
    
    final class CollectionViewCell: UICollectionViewCell {
        
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
}

extension StepsTableViewCell.CollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? StepsTableViewCell.CollectionViewCellModel else {
            return
        }
        
        iconImageView.image = model.iconImage
        titleLabel.text = model.titleText
        subTitleLabel.text = model.subTitleText
    }
}

extension StepsTableViewCell {
    
    final class CollectionViewCellModel: QuickCollectionViewCellModelProtocol {
        
        var type: QuickCollectionViewCellProtocol.Type { CollectionViewCell.self }
        
        var id: Int?
        
        var entity: IdentifiableEntity?
        
        var iconImage: UIImage
        
        var titleText: String
        
        var subTitleText: String
        
        init(id: Int? = nil,
             entity: IdentifiableEntity? = nil,
             iconImage: UIImage,
             titleText: String,
             subTitleText: String) {
            self.id = id
            self.entity = entity
            self.iconImage = iconImage
            self.titleText = titleText
            self.subTitleText = subTitleText
        }
    }
}
