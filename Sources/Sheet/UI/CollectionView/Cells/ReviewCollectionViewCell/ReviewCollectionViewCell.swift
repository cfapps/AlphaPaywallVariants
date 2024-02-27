//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import UIKit
import QuickToolKit

final class ReviewCollectionViewCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.secondarySystemBackground
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .callout, weight: .regular)
        label.textColor = UIColor.secondaryLabel.withAlphaComponent(0.3)
        label.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        return label
    }()
    
    private lazy var subjectLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingMiddle
        label.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
        label.textColor = UIColor.label
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular)
        label.textColor = UIColor.secondaryLabel.withAlphaComponent(0.6)
        return label
    }()
    
    private lazy var ratingView: UIView = {
        func makeStarView() -> UIView {
            let configuration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular))
            var image = UIImage(systemName: "star.fill")
            image = image?.applyingSymbolConfiguration(configuration)
            image = image?.withTintColor(UIColor.systemOrange, renderingMode: .alwaysOriginal)
            return UIImageView(image: image)
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
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(subjectLabel)
        containerView.addSubview(bodyLabel)
        containerView.addSubview(ratingView)
        
        contentView.addSubview(containerView)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(subjectLabel.snp.centerY)
            make.right.equalToSuperview().inset(16)
            make.left.greaterThanOrEqualTo(subjectLabel.snp.right).offset(8)
        }
        
        subjectLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.right.lessThanOrEqualTo(nameLabel.snp.left).offset(-8)
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel.snp.bottom).offset(6)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(bodyLabel.snp.bottom).offset(6)
            make.bottom.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.right.lessThanOrEqualToSuperview().inset(16)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ReviewCollectionViewCell: QuickCollectionViewCellProtocol {
    
    func update(model: QuickCollectionViewCellModelProtocol) {
        guard let model = model as? ReviewCollectionViewCellModel else {
            return
        }
        
        nameLabel.text = model.name
        subjectLabel.text = model.subject
        bodyLabel.text = model.body
    }
}
