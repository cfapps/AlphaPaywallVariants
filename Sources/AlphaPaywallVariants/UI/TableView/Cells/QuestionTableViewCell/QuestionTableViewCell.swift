//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class QuestionTableViewCell: UITableViewCell {
    
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
    
    private var isExpand: Bool = false {
        didSet {
            setExpand(isExpand)
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
    
    private lazy var containerContentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var headerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        descriptionLabel.isHidden = true
        
        contentView.addSubview(containerContentView)
        
        containerContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        containerContentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeaderView)))
    }
    
    private func setExpand(_ expand: Bool) {
        var v: UIView? = self
        
        while v != nil && !(v is UITableView) {
            v = v?.superview
        }
        
        guard let tableView = v as? UITableView else {
            return
        }
        
        if expand {
            descriptionLabel.isHidden = false
        } else {
            descriptionLabel.isHidden = true
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @objc private func didTapHeaderView() {
        isExpand = !isExpand
    }
}

extension QuestionTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? QuestionTableViewCellModel else {
            return
        }
        
        titleLabel.text = model.titleText
        descriptionLabel.text = model.descriptionText
    }
}
