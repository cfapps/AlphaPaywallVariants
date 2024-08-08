//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

final class BadgeView: UIView {
    
    private let colorAppearance: ColorAppearance
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        label.textColor = UIColor.white // TODO: Check color
        return label
    }()
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        label.textColor = UIColor.white // TODO: Check color
        return label
    }()
    
    init(colorAppearance: ColorAppearance) {
        self.colorAppearance = colorAppearance
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    var nameText: String? {
        didSet {
            nameLabel.text = nameText
        }
    }
    
    var badgeText: String? {
        didSet {
            badgeLabel.text = badgeText
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let contrainerView = {
            let view = UIView()
            view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            view.layer.cornerRadius = 6
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            view.layer.masksToBounds = true
            return view
        }()
        
        let nameContrainerView = {
            let view = UIView()
            return view
        }()
        
        let badgeContrainerView = {
            let view = UIView()
            view.backgroundColor = UIColor.black
            view.layer.cornerRadius = 6
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            view.layer.masksToBounds = true
            return view
        }()
        
        nameContrainerView.addSubview(nameLabel)
        badgeContrainerView.addSubview(badgeLabel)
        
        contrainerView.addSubview(nameContrainerView)
        contrainerView.addSubview(badgeContrainerView)
        
        addSubview(contrainerView)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.bottom.equalToSuperview().offset(-3)
            make.directionalHorizontalEdges.equalToSuperview().inset(8)
        }
        
        badgeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.bottom.equalToSuperview().offset(-3)
            make.directionalHorizontalEdges.equalToSuperview().inset(8)
        }
        
        nameContrainerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        badgeContrainerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.left.equalTo(nameContrainerView.snp.right)
            make.right.equalToSuperview()
        }
        
        contrainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
