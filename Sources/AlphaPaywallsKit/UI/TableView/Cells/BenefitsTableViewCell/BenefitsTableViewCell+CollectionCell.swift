//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

extension BenefitsTableViewCell {
    
    final class CollectionViewCell: UICollectionViewCell {
        
        var iconColor: UIColor = UIColor.label {
            didSet {
                iconImageView.image = iconImageView.image?.withTintColor(iconColor, renderingMode: .alwaysOriginal)
            }
        }
        
        var titleLabelColor: UIColor = UIColor.label {
            didSet {
                titleLabel.textColor = titleLabelColor
            }
        }
        
        var containerWidth: CGFloat? {
            didSet {
                if let containerWidth = containerWidth {
                    containerView.snp.remakeConstraints { make in
                        make.top.bottom.equalToSuperview()
                        make.left.greaterThanOrEqualToSuperview()
                        make.right.lessThanOrEqualToSuperview()
                        make.centerX.equalToSuperview()
                        make.width.equalTo(containerWidth)
                    }
                } else {
                    containerView.snp.remakeConstraints { make in
                        make.top.bottom.equalToSuperview()
                        make.left.greaterThanOrEqualToSuperview()
                        make.right.lessThanOrEqualToSuperview()
                        make.centerX.equalToSuperview()
                    }
                }
            }
        }
        
        var iconImage: UIImage? {
            didSet {
                iconImageView.image = iconImage?.withTintColor(iconColor, renderingMode: .alwaysOriginal)
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
            label.font = UIFont.preferredFont(forTextStyle: .body, weight: .regular)
            label.textColor = titleLabelColor
            label.setContentHuggingPriority(.defaultLow, for: .horizontal)
            return label
        }()
        
        private lazy var containerView = UIView()
        
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
            backgroundColor = .clear
            
            iconImageContainerView.addSubview(iconImageView)
            containerView.addSubview(iconImageContainerView)
            containerView.addSubview(titleLabel)
            contentView.addSubview(containerView)
            
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
            
            containerView.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.greaterThanOrEqualToSuperview()
                make.right.lessThanOrEqualToSuperview()
                make.centerX.equalToSuperview()
            }
        }
    }
}

extension BenefitsTableViewCell.CollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? BenefitsTableViewCell.CollectionViewCellModel else {
            return
        }
        
        titleText = model.text
        iconImage = model.icon
    }
}

extension BenefitsTableViewCell.CollectionViewCell {
    
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

extension BenefitsTableViewCell {
    
    final class CollectionViewCellModel: QuickCollectionViewCellModelProtocol {
        
        var type: QuickCollectionViewCellProtocol.Type { CollectionViewCell.self }
        
        var id: Int?
        
        var entity: IdentifiableEntity?
        
        var icon: UIImage
        
        var text: String
        
        init(id: Int? = nil,
             entity: IdentifiableEntity? = nil,
             icon: UIImage,
             text: String) {
            self.id = id
            self.entity = entity
            self.icon = icon
            self.text = text
        }
    }
}
