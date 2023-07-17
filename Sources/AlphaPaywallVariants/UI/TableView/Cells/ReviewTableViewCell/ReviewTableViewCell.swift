//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class ReviewTableViewCell: UITableViewCell {
    
    var contentBackgroundColor: UIColor = UIColor.gray.withAlphaComponent(0.15) {
        didSet {
            backgroundContentView.backgroundColor = contentBackgroundColor
        }
    }
    
    var primaryLabelColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = primaryLabelColor
        }
    }
    
    var secondaryLabelColor: UIColor = UIColor.secondaryLabel {
        didSet {
            descriptionLabel.textColor = secondaryLabelColor
            nameLabel.textColor = secondaryLabelColor.withAlphaComponent(0.3)
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
        label.textColor = primaryLabelColor
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular)
        label.textColor = secondaryLabelColor
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .callout, weight: .semibold)
        label.textColor = secondaryLabelColor.withAlphaComponent(0.3)
        return label
    }()
    
    private lazy var ratingView: UIView = {
        func makeStarView() -> UIView {
            return UIImageView(
                image: UIImage(systemName: "star.fill")?.applyingSymbolConfiguration(
                    UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular))
                )?.withTintColor(UIColor.orange, renderingMode: .alwaysOriginal)
            )
        }
        
        let stackView = UIStackView(arrangedSubviews: [
            makeStarView(),
            makeStarView(),
            makeStarView(),
            makeStarView(),
            makeStarView()
        ])
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
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
        
        contentContainerView.addSubview(titleLabel)
        contentContainerView.addSubview(descriptionLabel)
        contentContainerView.addSubview(nameLabel)
        contentContainerView.addSubview(ratingView)
        
        contentView.addSubview(backgroundContentView)
        contentView.addSubview(contentContainerView)
        
        backgroundContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(0)
            make.left.right.equalToSuperview()
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview()
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
    }
}

extension ReviewTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? ReviewTableViewCellModel else {
            return
        }
        
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        nameLabel.text = model.name
        
        backgroundContentView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(model.topInset)
            make.bottom.equalToSuperview().inset(model.bottomInset)
        }
        
        contentContainerView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(16 + model.topInset)
            make.bottom.equalToSuperview().inset(16 + model.bottomInset)
        }
    }
}
