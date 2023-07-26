//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class QuestionTableViewCell: UITableViewCell {
    
    private var model: QuestionTableViewCellModel?
    
    var primaryLabelColor: UIColor = UIColor.label {
        didSet {
            titleLabel.textColor = primaryLabelColor
        }
    }
    
    var secondaryLabelColor: UIColor = UIColor.secondaryLabel {
        didSet {
            descriptionLabel.textColor = secondaryLabelColor
        }
    }
    
    var collapsedChevronColor: UIColor = UIColor.opaqueSeparator
    
    var expandedChevronColor: UIColor = UIColor.separator
    
    var separatorColor: UIColor = UIColor.separator {
        didSet {
            separatorView.backgroundColor = separatorColor
        }
    }
    
    var containerInsets: UIEdgeInsets = .zero {
        didSet {
            contentContainerView.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(containerInsets.top)
                make.bottom.equalToSuperview().inset(containerInsets.bottom).priority(.medium)
                make.left.equalToSuperview().inset(containerInsets.left)
                make.right.equalToSuperview().inset(containerInsets.right)
            }
        }
    }
    
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
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.transform = CGAffineTransformMakeRotation(180 * Double.pi / 180)
        imageView.image = UIImage(systemName: "chevron.up")?
            .applyingSymbolConfiguration(
                UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .body, weight: .bold))
            )?
            .withTintColor(collapsedChevronColor, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private lazy var titleContainerView = UIView()
    
    private lazy var descriptionContainerView = UIView()
    
    private lazy var contentContainerView = UIView()
    
    private lazy var chevronContainerView = UIView()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = separatorColor
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        chevronContainerView.addSubview(chevronImageView)
        
        titleContainerView.addSubview(titleLabel)
        titleContainerView.addSubview(chevronContainerView)
        descriptionContainerView.addSubview(descriptionLabel)
        
        contentContainerView.addSubview(titleContainerView)
        contentContainerView.addSubview(separatorView)
        
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
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().priority(.medium)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        titleContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapExpand)))
    }
    
    @objc private func didTapExpand() {
        isExpand = !isExpand
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
        
        UIView.animate(withDuration: 0.3, animations: {
            self.setChevron(color: self.expandedChevronColor)
            self.chevronImageView.transform = CGAffineTransformMakeRotation(0 * Double.pi / 180)
            
            if let tableView = self.superview as? UITableView {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        })
    }
    
    public func collapse() {
        descriptionContainerView.snp.remakeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleContainerView.snp.bottom)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.setChevron(color: self.collapsedChevronColor)
            self.chevronImageView.transform = CGAffineTransformMakeRotation(180 * Double.pi / 180)
            
            if let tableView = self.superview as? UITableView {
                tableView.beginUpdates()
                tableView.endUpdates()
            }
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
        
        containerInsets = model.insets
        
        primaryLabelColor = model.primaryLabelColor
        secondaryLabelColor = model.secondaryLabelColor
        collapsedChevronColor = model.collapsedChevronColor
        expandedChevronColor = model.expandedChevronColor
        separatorColor = model.separatorColor
        
        titleLabel.text = model.titleText
        descriptionLabel.text = model.descriptionText
        separatorView.isHidden = !model.showSeparator
    }
}
