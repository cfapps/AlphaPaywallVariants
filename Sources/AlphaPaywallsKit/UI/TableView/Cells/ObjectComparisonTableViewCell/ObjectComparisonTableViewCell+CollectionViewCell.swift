//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

extension ObjectComparisonTableViewCell {
    
    final class CollectionViewCell: UICollectionViewCell {
        
        var textColor: UIColor = UIColor.label {
            didSet {
                titleLabel.textColor = textColor
            }
        }
        
        var positiveColor: UIColor = UIColor.green {
            didSet {
                checkmarkView.image = checkmarkView.image?.withTintColor(positiveColor, renderingMode: .alwaysOriginal)
            }
        }
        
        var negativeColor: UIColor = UIColor.red {
            didSet {
                xmarkView.image = xmarkView.image?.withTintColor(negativeColor, renderingMode: .alwaysOriginal)
            }
        }
        
        var titleText: String? {
            didSet {
                titleLabel.text = titleText
            }
        }
        
        var optionWidth: CGFloat = 0 {
            didSet {
                firstOptionView.snp.updateConstraints { make in
                    make.width.equalTo(optionWidth)
                }
                secondOptionView.snp.updateConstraints { make in
                    make.width.equalTo(optionWidth)
                }
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .bold)
            label.textColor = textColor
            return label
        }()
        
        private lazy var checkmarkView: UIImageView = {
            let imageView = UIImageView(
                image: UIImage(systemName: "checkmark")?
                    .withTintColor(positiveColor, renderingMode: .alwaysOriginal)
                    .applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .heavy)))
            )
            imageView.contentMode = .center
            return imageView
        }()
        
        private lazy var xmarkView: UIImageView = {
            let imageView = UIImageView(
                image: UIImage(systemName: "xmark")?
                    .withTintColor(negativeColor, renderingMode: .alwaysOriginal)
                    .applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .heavy)))
            )
            imageView.contentMode = .center
            return imageView
        }()
        
        private lazy var firstOptionView = UIView()
        
        private lazy var secondOptionView = UIView()
        
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
            firstOptionView.addSubview(xmarkView)
            secondOptionView.addSubview(checkmarkView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(firstOptionView)
            contentView.addSubview(secondOptionView)
            
            checkmarkView.snp.makeConstraints { make in
                make.center.equalToSuperview().priority(.medium)
                make.top.left.greaterThanOrEqualToSuperview()
                make.right.bottom.lessThanOrEqualToSuperview()
            }
            
            xmarkView.snp.makeConstraints { make in
                make.center.equalToSuperview().priority(.medium)
                make.top.left.greaterThanOrEqualToSuperview()
                make.right.bottom.lessThanOrEqualToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(16)
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(firstOptionView.snp.left)
            }
            
            firstOptionView.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.right.equalTo(secondOptionView.snp.left)
                make.width.equalTo(0)
            }
            
            secondOptionView.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.right.equalToSuperview()
                make.width.equalTo(0)
            }
        }
    }
}

extension ObjectComparisonTableViewCell.CollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? ObjectComparisonTableViewCell.CollectionViewCellModel else {
            return
        }
        
        titleText = model.text
    }
}

extension ObjectComparisonTableViewCell {
    
    final class CollectionViewCellModel: QuickCollectionViewCellModelProtocol {
        
        static var type: QuickCollectionViewCellProtocol.Type { CollectionViewCell.self }
        
        var id: Int?
        
        var entity: IdentifiableEntity?
        
        var text: String
        
        init(id: Int? = nil,
             entity: IdentifiableEntity? = nil,
             text: String) {
            self.id = id
            self.entity = entity
            self.text = text
        }
    }
}
