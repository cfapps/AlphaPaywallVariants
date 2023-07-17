//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit
import SnapKit

final class AwardTableViewCell: UITableViewCell {
    
    var contentBackgroundColor: UIColor = UIColor.tertiarySystemBackground {
        didSet {
            backgroundContentView.backgroundColor = contentBackgroundColor
        }
    }
    
    var textLabelColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = textLabelColor
            subTitleLabel.textColor = textLabelColor
            detailsLabel.textColor = textLabelColor
            iconImageView.image = iconImageView.image?.withTintColor(textLabelColor, renderingMode: .alwaysOriginal)
        }
    }
    
    private lazy var backgroundContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = contentBackgroundColor
        return view
    }()
    
    private lazy var contentContainerView = UIView()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "laurel.apple", in: .module, with: nil)?.withTintColor(textLabelColor, renderingMode: .alwaysOriginal)
        imageView.contentMode = .center
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3, weight: .semibold)
        label.textColor = textLabelColor
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .callout, weight: .bold)
        label.textColor = textLabelColor
        return label
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = textLabelColor
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
        backgroundView = UIView()
        selectedBackgroundView = UIView()
        backgroundColor = .clear
        
        contentContainerView.addSubview(iconImageView)
        contentContainerView.addSubview(titleLabel)
        contentContainerView.addSubview(subTitleLabel)
        contentContainerView.addSubview(detailsLabel)
        
        contentView.addSubview(backgroundContentView)
        contentView.addSubview(contentContainerView)
        
        
        backgroundContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(24)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(16)
//            make.top.equalToSuperview()
            make.width.equalTo(73)
            make.height.equalTo(37)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(detailsLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().priority(.medium)
        }
        
        detailsLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.greaterThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(8)
        }
    }
}

extension AwardTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? AwardTableViewCellModel else {
            return
        }
        
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        detailsLabel.text = model.details
        textLabelColor = model.textColor
        contentBackgroundColor = model.contentColor
    }
}
