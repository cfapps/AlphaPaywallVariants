//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class BadgeView: UIView {
    
    var labelColor: UIColor = UIColor.label {
        didSet {
            badgeLabel.textColor = labelColor
        }
    }
    
    var text: String? {
        didSet {
            badgeLabel.text = text
        }
    }
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        label.font = UIFont.preferredFont(forTextStyle: .subheadline, weight: .semibold)
        label.textColor = labelColor
        return label
    }()
    
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
        addSubview(badgeLabel)
        
        badgeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.bottom.equalToSuperview().inset(6)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }
    }
}
