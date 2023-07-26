//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class ToastTableViewCell: UITableViewCell {
    
    var iconName: String? {
        didSet {
            guard let iconName = iconName, let image = UIImage(systemName: iconName) else {
                iconImageView.image = nil
                return
            }
            
            iconImageView.image = image
                .applyingSymbolConfiguration(UIImage.SymbolConfiguration(
                    font: UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold)
                ))?
                .withTintColor(iconColor, renderingMode: .alwaysOriginal)
        }
    }
    
    var text: String? {
        didSet {
            titleLabel.text = text
        }
    }
    
    var iconColor: UIColor = UIColor.systemGreen {
        didSet {
            iconImageView.image = iconImageView.image?.withTintColor(iconColor, renderingMode: .alwaysOriginal)
        }
    }
    
    var textColor: UIColor = UIColor.systemGreen {
        didSet {
            titleLabel.textColor = textColor
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.right.equalTo(titleLabel.snp.left).offset(-4)
            make.centerY.equalTo(titleLabel)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().priority(.medium)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension ToastTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? ToastTableViewCellModel else {
            return
        }
        
        iconColor = model.iconColor
        textColor = model.textColor
        iconName = model.iconName
        text = model.text
    }
}
