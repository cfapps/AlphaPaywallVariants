//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit

public final class BadgeLabel: UIView {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = textColor
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    public var textColor: UIColor = UIColor.label {
        didSet {
            label.textColor = textColor
        }
    }
    
    public var text: String? {
        didSet {
            label.text = text
        }
    }
    
    public var isCornersRounded: Bool = false {
        didSet {
            layer.cornerRadius = calculatedCornerRadius
            layer.masksToBounds = isCornersRounded
        }
    }
    
    private var calculatedCornerRadius: CGFloat {
        if isCornersRounded {
            return layer.frame.height / 2
        }
        
        return 0
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = calculatedCornerRadius
        layer.masksToBounds = true
        
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview().inset(5)
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if isCornersRounded {
            layer.cornerRadius = calculatedCornerRadius
        }
    }
}
