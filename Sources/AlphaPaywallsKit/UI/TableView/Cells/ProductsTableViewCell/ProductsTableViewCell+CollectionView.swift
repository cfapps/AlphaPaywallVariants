//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import QuickTableKit

extension ProductsTableViewCell {
    
    class CollectionViewCell: UICollectionViewCell {
        
        var containerBackgroundColor: UIColor = UIColor.systemBackground {
            didSet {
                containerBackgroundView.backgroundColor = containerBackgroundColor
            }
        }
        
        var containerUnselectedColor: UIColor = UIColor.opaqueSeparator {
            didSet {
                if !isSelected {
                    selectedContainerBackgroundView.layer.borderColor = containerUnselectedColor.cgColor
                }
            }
        }
        
        var containerSelectedColor: UIColor = UIColor.systemBlue {
            didSet {
                selectedCheckmarkView.image = selectedCheckmarkView.image?.withTintColor(containerSelectedColor, renderingMode: .alwaysOriginal)
                
                if isSelected {
                    selectedContainerBackgroundView.layer.backgroundColor = containerSelectedColor.withAlphaComponent(0.08).cgColor
                    selectedContainerBackgroundView.layer.borderColor = containerSelectedColor.cgColor
                }
            }
        }
        
        var textColor: UIColor = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1) {
            didSet {
                titleLabel.textColor = textColor
                descriptionLabel.textColor = textColor
            }
        }
        
        var checkmarkColor: UIColor = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1) {
            didSet {
                unselectedCheckmarkView.image = unselectedCheckmarkView.image?.withTintColor(checkmarkColor, renderingMode: .alwaysOriginal)
            }
        }
        
        var badgeColor: UIColor = UIColor(red: 0, green: 122 / 255, blue: 1, alpha: 1) {
            didSet {
                badgeView.backgroundColor = badgeColor
            }
        }
        
        var badgeTextColor: UIColor = UIColor.white {
            didSet {
                badgeView.textColor = badgeTextColor
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
            view.layer.borderColor = containerUnselectedColor.cgColor
            return view
        }()
        
        private lazy var checkmarkContainerView = UIView()
        
        private lazy var unselectedCheckmarkView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "circle")?
                .withConfiguration(UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 22)))
                .withTintColor(containerUnselectedColor, renderingMode: .alwaysOriginal)
            return imageView
        }()
        
        private lazy var selectedCheckmarkView: UIImageView = {
            let imageView = UIImageView()
            imageView.isHidden = true
            imageView.image = UIImage(systemName: "checkmark.circle.fill")?
                .withConfiguration(UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 22)))
                .withTintColor(containerSelectedColor, renderingMode: .alwaysOriginal)
            return imageView
        }()
        
        private lazy var badgeView: BadgeView = {
            let view = BadgeView()
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.layer.backgroundColor = badgeColor.cgColor
            view.textColor = badgeTextColor
            return view
        }()
        
        private lazy var topContainerView: UIView = {
            let view = UIView()
            return view
        }()
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
            label.textColor = textColor
            return label
        }()
        
        private lazy var descriptionLabelContainerView = UIView()
        
        private lazy var descriptionLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 2
            label.lineBreakMode = .byTruncatingTail
            label.font = UIFont.preferredFont(forTextStyle: .caption1, weight: .regular)
            label.textColor = textColor
            return label
        }()
        
        override var isSelected: Bool {
            didSet {
                if isSelected {
                    unselectedCheckmarkView.isHidden = true
                    selectedCheckmarkView.isHidden = false
                    
                    selectedContainerBackgroundView.layer.backgroundColor = containerSelectedColor.withAlphaComponent(0.08).cgColor
                    selectedContainerBackgroundView.layer.borderWidth = 2
                    selectedContainerBackgroundView.layer.borderColor = containerSelectedColor.cgColor
                } else {
                    unselectedCheckmarkView.isHidden = false
                    selectedCheckmarkView.isHidden = true
                    
                    selectedContainerBackgroundView.layer.backgroundColor = nil
                    selectedContainerBackgroundView.layer.borderWidth = 1
                    selectedContainerBackgroundView.layer.borderColor = containerUnselectedColor.cgColor
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
            selectedContainerBackgroundView.layer.borderColor = containerUnselectedColor.cgColor
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            let h = calculateDescriptionHeight("\n", width: contentView.frame.width + 28)
            if descriptionLabelContainerView.frame.height != h {
                descriptionLabelContainerView.snp.updateConstraints { make in
                    make.height.equalTo(h)
                }
            }
        }
        
        private func setupUI() {
            contentView.addSubview(containerBackgroundView)
            contentView.addSubview(selectedContainerBackgroundView)
            checkmarkContainerView.addSubview(unselectedCheckmarkView)
            checkmarkContainerView.addSubview(selectedCheckmarkView)
            topContainerView.addSubview(checkmarkContainerView)
            topContainerView.addSubview(badgeView)
            descriptionLabelContainerView.addSubview(descriptionLabel)
            contentView.addSubview(topContainerView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(descriptionLabelContainerView)
            
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
            
            descriptionLabelContainerView.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(2)
                make.bottom.equalToSuperview().inset(16).priority(.medium)
                make.left.equalToSuperview().inset(14)
                make.right.equalToSuperview().inset(14)
                make.height.equalTo(0)
            }
            
            descriptionLabel.snp.makeConstraints { make in
                make.directionalHorizontalEdges.equalToSuperview()
                make.top.equalToSuperview()
                make.bottom.lessThanOrEqualToSuperview()
            }
        }
        
        private func calculateDescriptionHeight(_ text: String, width: CGFloat) -> CGFloat {
            let label = UILabel()
            label.font = descriptionLabel.font
            label.text = text
            let size = label.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
            return size.height
        }
    }
    
    class CollectionViewCellModel: QuickCollectionViewCellModelProtocol {
        
        var type: QuickCollectionViewCellProtocol.Type { CollectionViewCell.self }
        
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
        
        init(id: Int? = nil,
             entity: IdentifiableEntity? = nil,
             titleText: String? = nil,
             descriptionText: String? = nil,
             badge: Badge? = nil) {
            self.id = id
            self.entity = entity
            self.titleText = titleText
            self.descriptionText = descriptionText
            self.badge = badge
        }
    }
}

extension ProductsTableViewCell.CollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? ProductsTableViewCell.CollectionViewCellModel else {
            return
        }
        
        titleLabel.text = model.titleText
        descriptionLabel.text = model.descriptionText
        
        if let badge = model.badge {
            badgeColor = badge.color
            badgeTextColor = badge.textColor
            badgeView.text = badge.text
            badgeView.isHidden = false
        } else {
            badgeView.isHidden = true
            badgeView.text = nil
        }
    }
}
