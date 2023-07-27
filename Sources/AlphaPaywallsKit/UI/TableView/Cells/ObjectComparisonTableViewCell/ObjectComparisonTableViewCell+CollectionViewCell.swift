//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

extension ObjectComparisonTableViewCell {
    
    final class CollectionViewCell: UICollectionViewCell {
        
        var labelColor: UIColor = UIColor.label {
            didSet {
                titleLabel.textColor = labelColor
            }
        }
        
        var checkedColor: UIColor = UIColor.green {
            didSet {
                optionOneCheckmark.checkedColor = checkedColor
                optionTwoCheckmark.checkedColor = checkedColor
            }
        }
        
        var uncheckedColor: UIColor = UIColor.red {
            didSet {
                optionOneCheckmark.uncheckedColor = uncheckedColor
                optionTwoCheckmark.uncheckedColor = uncheckedColor
            }
        }
        
        var titleText: String? {
            didSet {
                titleLabel.text = titleText
            }
        }
        
        var optionWidth: CGFloat = 0 {
            didSet {
                optionOneCheckmark.snp.updateConstraints { make in
                    make.width.equalTo(optionWidth)
                }
                optionTwoCheckmark.snp.updateConstraints { make in
                    make.width.equalTo(optionWidth)
                }
            }
        }
        
        private lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .bold)
            label.textColor = labelColor
            return label
        }()
        
        private lazy var optionOneCheckmark: CheckmarkView = {
            let checkmark = CheckmarkView()
            checkmark.uncheckedColor = uncheckedColor
            checkmark.checkedColor = checkedColor
            return checkmark
        }()
        
        private lazy var optionTwoCheckmark: CheckmarkView = {
            let checkmark = CheckmarkView()
            checkmark.uncheckedColor = uncheckedColor
            checkmark.checkedColor = checkedColor
            return checkmark
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
            contentView.addSubview(titleLabel)
            contentView.addSubview(optionOneCheckmark)
            contentView.addSubview(optionTwoCheckmark)
            
            titleLabel.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(16)
                make.left.equalToSuperview().inset(16)
                make.right.equalTo(optionOneCheckmark.snp.left)
            }
            
            optionOneCheckmark.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.right.equalTo(optionTwoCheckmark.snp.left)
                make.width.equalTo(0)
            }
            
            optionTwoCheckmark.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
                make.right.equalToSuperview()
                make.width.equalTo(0)
            }
        }
        
        private func makeCheckmark(_ exist: Bool) -> UIImageView {
            let imageView = UIImageView()
            
            imageView.contentMode = .center
            return imageView
        }
    }
}

extension ObjectComparisonTableViewCell.CollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? ObjectComparisonTableViewCell.CollectionViewCellModel else {
            return
        }
        
        titleText = model.titleText
        optionOneCheckmark.isChecked = model.hasOptionOne
        optionTwoCheckmark.isChecked = model.hasOptionTwo
    }
}

extension ObjectComparisonTableViewCell {
    
    final class CollectionViewCellModel: QuickCollectionViewCellModelProtocol {
        
        var type: QuickCollectionViewCellProtocol.Type { CollectionViewCell.self }
        
        var id: Int?
        
        var entity: IdentifiableEntity?
        
        var titleText: String
        
        var hasOptionOne: Bool
        
        var hasOptionTwo: Bool
        
        init(id: Int? = nil,
             entity: IdentifiableEntity? = nil,
             titleText: String,
             hasOptionOne: Bool,
             hasOptionTwo: Bool) {
            self.id = id
            self.entity = entity
            self.titleText = titleText
            self.hasOptionOne = hasOptionOne
            self.hasOptionTwo = hasOptionTwo
        }
    }
}

private class CheckmarkView: UIView {
    
    var uncheckedColor: UIColor = UIColor.red {
        didSet {
            guard !isChecked else { return }
            imageView.image = uncheckedImage?.withTintColor(uncheckedColor, renderingMode: .alwaysOriginal)
        }
    }
    
    var checkedColor: UIColor = UIColor.green {
        didSet {
            guard isChecked else { return }
            imageView.image = checkedImage?.withTintColor(checkedColor, renderingMode: .alwaysOriginal)
        }
    }
    
    private var uncheckedImage: UIImage? = {
        UIImage(systemName: "xmark")?
            .applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .heavy)))
    }()
    
    private var checkedImage: UIImage? = {
        UIImage(systemName: "checkmark")?
            .applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .heavy)))
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = uncheckedImage?.withTintColor(uncheckedColor, renderingMode: .alwaysOriginal)
        imageView.contentMode = .center
        return imageView
    }()
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                imageView.image = checkedImage?.withTintColor(checkedColor, renderingMode: .alwaysOriginal)
            } else {
                imageView.image = uncheckedImage?.withTintColor(uncheckedColor, renderingMode: .alwaysOriginal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.left.greaterThanOrEqualToSuperview()
            make.bottom.right.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
    }
}
