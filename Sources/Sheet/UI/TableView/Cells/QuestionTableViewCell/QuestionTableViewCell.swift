//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickToolKit

final class QuestionTableViewCell: UITableViewCell {
    
    private var model: QuestionTableViewCellModel?
    
    private var isExpand: Bool = false {
        didSet {
            if isExpand {
                expand()
            } else {
                collapse()
            }
            
            model?.expand = isExpand
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body, weight: .semibold)
        label.textColor = titleTextColor
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .regular)
        label.textColor = descriptionTextColor
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.transform = CGAffineTransformMakeRotation(-Double.pi)
        imageView.image = UIImage(systemName: "chevron.up")?
            .applyingSymbolConfiguration(
                UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, weight: .bold))
            )?
            .withTintColor(UIColor.tertiaryLabel.withAlphaComponent(0.6), renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private lazy var titleContainerView = UIView()
    
    private lazy var descriptionContainerView = UIView()
    
    private lazy var contentContainerView = UIView()
    
    private lazy var chevronContainerView = UIView()
    
    var titleTextColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = titleTextColor
        }
    }
    
    var descriptionTextColor: UIColor = UIColor.secondaryLabel {
        didSet {
            descriptionLabel.textColor = descriptionTextColor
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle() {
        isExpand = !isExpand
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        chevronContainerView.addSubview(chevronImageView)
        
        titleContainerView.addSubview(titleLabel)
        titleContainerView.addSubview(chevronContainerView)
        descriptionContainerView.addSubview(descriptionLabel)
        
        contentContainerView.addSubview(titleContainerView)
        
        contentView.addSubview(contentContainerView)
        
        chevronImageView.snp.makeConstraints { make in
            make.top.left.greaterThanOrEqualToSuperview()
            make.bottom.right.lessThanOrEqualToSuperview()
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.left.equalToSuperview()
            make.right.lessThanOrEqualTo(chevronContainerView.snp.left).offset(-8)
        }
        
        chevronContainerView.snp.makeConstraints { make in
            make.width.equalTo(35)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        titleContainerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().priority(.medium)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func setChevron(color: UIColor) {
        chevronImageView.image = chevronImageView.image?.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}

extension QuestionTableViewCell {
    
    public func expand() {
        contentContainerView.addSubview(descriptionContainerView)
        
        descriptionContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleContainerView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
            self.setChevron(color: UIColor.tertiaryLabel.withAlphaComponent(0.3))
            self.chevronImageView.transform = CGAffineTransformMakeRotation(2 * Double.pi)
        })
    }
    
    public func collapse() {
        descriptionContainerView.snp.remakeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleContainerView.snp.bottom)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
            self.setChevron(color: UIColor.tertiaryLabel.withAlphaComponent(0.6))
            self.chevronImageView.transform = CGAffineTransformMakeRotation(-Double.pi)
        }, completion: { _ in
            self.descriptionContainerView.removeFromSuperview()
            self.descriptionContainerView.snp.removeConstraints()
        })
    }
}

extension QuestionTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? QuestionTableViewCellModel else {
            return
        }
        
        self.model = model
        
        titleLabel.text = model.titleText
        descriptionLabel.text = model.descriptionText
    }
}
