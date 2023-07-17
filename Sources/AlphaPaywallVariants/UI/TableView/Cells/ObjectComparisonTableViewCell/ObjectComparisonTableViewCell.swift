//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit
import SnapKit

final class ObjectComparisonTableViewCell: UITableViewCell {
    
    var contentBackgroundColor: UIColor = UIColor.tertiarySystemBackground {
        didSet {
            backgroundContentView.backgroundColor = contentBackgroundColor
        }
    }
    
    var textLabelColor: UIColor = UIColor.label {
        didSet {
            itemHeaderLabel.textColor = textLabelColor
            firstOptionHeaderLabel.textColor = textLabelColor
            secondOptionHeaderLabel.textColor = textLabelColor
        }
    }
    
    var positiveColor: UIColor = UIColor.label {
        didSet {
            
        }
    }
    
    var negativeColor: UIColor = UIColor.red {
        didSet {
            
        }
    }
    
    private lazy var backgroundContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = contentBackgroundColor
        return view
    }()
    
    private lazy var contentContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var itemHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = textLabelColor
        return label
    }()
    
    private lazy var firstOptionHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = textLabelColor
        return label
    }()
    
    private lazy var secondOptionHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = textLabelColor
        return label
    }()
    
    private lazy var contentHeaderView = UIView()
    
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
        
        contentHeaderView.addSubview(itemHeaderLabel)
        contentHeaderView.addSubview(firstOptionHeaderLabel)
        contentHeaderView.addSubview(secondOptionHeaderLabel)
        
        contentContainerView.addArrangedSubview(contentHeaderView)
        
        contentView.addSubview(backgroundContentView)
        contentView.addSubview(contentContainerView)
        
        backgroundContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        itemHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(firstOptionHeaderLabel.snp.left).offset(-8)
        }
        
        firstOptionHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalTo(secondOptionHeaderLabel.snp.left).offset(-24)
        }
        
        secondOptionHeaderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    private func addOption(text: String) {
        func makeCheckmarkView() -> UIView {
            let imageView = UIImageView(
                image: UIImage(systemName: "checkmark")?
                    .withTintColor(positiveColor, renderingMode: .alwaysOriginal)
                    .applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .heavy)))
            )
            imageView.contentMode = .center
            return imageView
        }
        
        func makeXmarkView() -> UIView {
            let imageView = UIImageView(
                image: UIImage(systemName: "xmark")?
                    .withTintColor(negativeColor, renderingMode: .alwaysOriginal)
                    .applyingSymbolConfiguration(UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .subheadline, weight: .heavy)))
            )
            imageView.contentMode = .center
            return imageView
        }
        
        let containerView = UIView()
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byCharWrapping
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.text = text
        
        let xmarkView = makeXmarkView()
        let checkmarkView = makeCheckmarkView()
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(xmarkView)
        containerView.addSubview(checkmarkView)
        
        contentContainerView.addArrangedSubview(containerView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(itemHeaderLabel.snp.right)
        }
        
        xmarkView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(firstOptionHeaderLabel.snp.centerX)
        }
        
        checkmarkView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalTo(secondOptionHeaderLabel.snp.centerX)
        }
    }
}

extension ObjectComparisonTableViewCell: QuickTableViewCellProtocol {
    
    func update(model: QuickTableViewCellModelProtocol) {
        guard let model = model as? ObjectComparisonTableViewCellModel else {
            return
        }
        
        textLabelColor = model.textColor
        contentBackgroundColor = model.contentColor
        
        positiveColor = model.textColor
        negativeColor = UIColor(red: 1, green: 0.23, blue: 0.19, alpha: 1)
        
        itemHeaderLabel.text = "Feature"
        firstOptionHeaderLabel.text = "Free"
        secondOptionHeaderLabel.text = "Pro"
        
        for item in model.items {
            addOption(text: item)
        }
    }
}
