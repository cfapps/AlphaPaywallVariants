//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import QuickTableKit

extension OptionsTableViewCell {
    
    class CollectionViewCell: UICollectionViewCell {
        
        var cellBackgroundColor: UIColor = UIColor.systemBackground {
            didSet {
                containerBackgroundView.backgroundColor = cellBackgroundColor
            }
        }
        
        var unselectedColor: UIColor = UIColor.opaqueSeparator {
            didSet {
                unselectedCheckmarkView.image = unselectedCheckmarkView.image?.withTintColor(unselectedColor, renderingMode: .alwaysOriginal)
                
                if !isSelected {
                    selectedContainerBackgroundView.layer.borderColor = unselectedColor.cgColor
                }
            }
        }
        
        var selectedColor: UIColor = UIColor.systemBlue {
            didSet {
                selectedCheckmarkView.image = selectedCheckmarkView.image?.withTintColor(selectedColor, renderingMode: .alwaysOriginal)
                
                if isSelected {
                    selectedContainerBackgroundView.layer.backgroundColor = selectedColor.withAlphaComponent(0.08).cgColor
                    selectedContainerBackgroundView.layer.borderColor = selectedColor.cgColor
                }
            }
        }
        
        var labelColor: UIColor = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1) {
            didSet {
                titleLabel.textColor = labelColor
                descriptionLabel.textColor = labelColor
            }
        }
        
        var badgeColor: UIColor = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1) {
            didSet {
                badgeView.backgroundColor = badgeColor
            }
        }
        
        var badgeLabelColor: UIColor = UIColor.white {
            didSet {
                badgeView.labelColor = badgeLabelColor
            }
        }
        
        private lazy var containerBackgroundView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 16
            view.layer.masksToBounds = true
            return view
        }()
        
        private lazy var selectedContainerBackgroundView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 16
            view.layer.masksToBounds = true
            view.layer.backgroundColor = nil
            view.layer.borderWidth = 1
            view.layer.borderColor = unselectedColor.cgColor
            return view
        }()
        
        private lazy var checkmarkContainerView = UIView()
        
        private lazy var unselectedCheckmarkView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "circle")?
                .withConfiguration(UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 22)))
                .withTintColor(unselectedColor, renderingMode: .alwaysOriginal)
            return imageView
        }()
        
        private lazy var selectedCheckmarkView: UIImageView = {
            let imageView = UIImageView()
            imageView.isHidden = true
            imageView.image = UIImage(systemName: "checkmark.circle.fill")?
                .withConfiguration(UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 22)))
                .withTintColor(selectedColor, renderingMode: .alwaysOriginal)
            return imageView
        }()
        
        private lazy var badgeView: BadgeView = {
            let view = BadgeView()
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.layer.backgroundColor = badgeColor.cgColor
            view.labelColor = badgeLabelColor
            return view
        }()
        
        private lazy var topContainerView: UIView = {
            let view = UIView()
            return view
        }()
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
            label.textColor = labelColor
            return label
        }()
        
        private lazy var descriptionLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = UIFont.preferredFont(forTextStyle: .caption1, weight: .regular)
            label.textColor = labelColor
            return label
        }()
        
        override var isSelected: Bool {
            didSet {
                if isSelected {
                    unselectedCheckmarkView.isHidden = true
                    selectedCheckmarkView.isHidden = false
                    
                    selectedContainerBackgroundView.layer.backgroundColor = selectedColor.withAlphaComponent(0.08).cgColor
                    selectedContainerBackgroundView.layer.borderWidth = 2
                    selectedContainerBackgroundView.layer.borderColor = selectedColor.cgColor
                } else {
                    unselectedCheckmarkView.isHidden = false
                    selectedCheckmarkView.isHidden = true
                    
                    selectedContainerBackgroundView.layer.backgroundColor = nil
                    selectedContainerBackgroundView.layer.borderWidth = 1
                    selectedContainerBackgroundView.layer.borderColor = unselectedColor.cgColor
                }
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
            unselectedCheckmarkView.isHidden = false
            selectedCheckmarkView.isHidden = true
            selectedContainerBackgroundView.layer.backgroundColor = nil
            selectedContainerBackgroundView.layer.borderWidth = 1
            selectedContainerBackgroundView.layer.borderColor = unselectedColor.cgColor
        }
        
        private func setupUI() {
            contentView.addSubview(containerBackgroundView)
            contentView.addSubview(selectedContainerBackgroundView)
            checkmarkContainerView.addSubview(unselectedCheckmarkView)
            checkmarkContainerView.addSubview(selectedCheckmarkView)
            topContainerView.addSubview(checkmarkContainerView)
            topContainerView.addSubview(badgeView)
            contentView.addSubview(topContainerView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(descriptionLabel)
            
            containerBackgroundView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            selectedContainerBackgroundView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            unselectedCheckmarkView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            selectedCheckmarkView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            checkmarkContainerView.snp.makeConstraints { make in
                make.height.width.equalTo(32)
                make.left.equalToSuperview()
                make.top.greaterThanOrEqualToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
                make.centerY.equalToSuperview()
            }
            
            badgeView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.right.equalToSuperview()
                make.left.greaterThanOrEqualTo(checkmarkContainerView.snp.right).offset(8)
            }
            
            topContainerView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(16)
                make.left.equalToSuperview().inset(14)
                make.right.equalToSuperview().inset(14)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(topContainerView.snp.bottom).offset(8)
                make.leading.equalToSuperview().inset(14)
                make.trailing.equalToSuperview().inset(14)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(2)
                make.bottom.equalToSuperview().inset(16).priority(.medium)
                make.leading.equalToSuperview().inset(14)
                make.trailing.equalToSuperview().inset(14)
            }
        }
    }
    
    class CollectionViewCellModel: QuickCollectionViewCellModelProtocol {
        
        static var type: QuickCollectionViewCellProtocol.Type { CollectionViewCell.self }
        
        struct Badge {
            
            let text: String
            
            let color: UIColor
            
            let textColor: UIColor
        }
        
        var id: Int?
        
        var entity: IdentifiableEntity?
        
        var titleText: String?
        
        var descriptionText: String?
        
        var badge: Badge?
        
        let backgroundColor: UIColor
        
        let labelColor: UIColor
        
        let unselectedColor: UIColor
        
        let selectedColor: UIColor
        
        init(id: Int? = nil,
             entity: IdentifiableEntity? = nil,
             titleText: String? = nil,
             descriptionText: String? = nil,
             badge: Badge? = nil,
             backgroundColor: UIColor,
             labelColor: UIColor,
             unselectedColor: UIColor,
             selectedColor: UIColor) {
            self.id = id
            self.entity = entity
            self.titleText = titleText
            self.descriptionText = descriptionText
            self.badge = badge
            self.backgroundColor = backgroundColor
            self.labelColor = labelColor
            self.unselectedColor = unselectedColor
            self.selectedColor = selectedColor
        }
    }
}

extension OptionsTableViewCell.CollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? OptionsTableViewCell.CollectionViewCellModel else {
            return
        }
        
        cellBackgroundColor = model.backgroundColor
        labelColor = model.labelColor
        unselectedColor = model.unselectedColor
        selectedColor = model.selectedColor
        
        titleLabel.text = model.titleText
        descriptionLabel.text = model.descriptionText
        
        if let badge = model.badge {
            badgeColor = badge.color
            badgeLabelColor = badge.textColor
            badgeView.text = badge.text
            badgeView.isHidden = false
        } else {
            badgeView.isHidden = true
            badgeView.text = nil
        }
    }
}
