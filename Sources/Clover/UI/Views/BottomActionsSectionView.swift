//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

import UIKit
import SharedKit
import SnapKit

final class BottomActionsSectionView: UIView {
    
    private var primaryButtonBottomConstraint: Constraint?
    
    private lazy var primaryButton: PrimaryButton = {
        let button = PrimaryButton()
        button.textFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.textColor = primaryButtonTextColor
        button.backgroundContentColor = primaryButtonBackgroundColor
        button.text = primaryButtonText
        button.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondaryButton: TextButton = {
        let button = TextButton()
        button.textFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.textColor = secondaryButtonTextColor
        button.text = secondaryButtonText
        button.addTarget(self, action: #selector(didTapSecondaryButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var primaryButtonTextColor: UIColor = UIColor.label {
        didSet {
            primaryButton.textColor = primaryButtonTextColor
        }
    }
    
    var primaryButtonBackgroundColor: UIColor = UIColor.label {
        didSet {
            primaryButton.backgroundContentColor = primaryButtonBackgroundColor
        }
    }
    
    var secondaryButtonTextColor: UIColor = UIColor.label {
        didSet {
            secondaryButton.textColor = secondaryButtonTextColor
        }
    }
    
    var isAvailableSecondaryButton: Bool = false {
        didSet {
            if isAvailableSecondaryButton {
                insertSecondaryButton()
            } else if secondaryButton.superview != nil {
                secondaryButton.removeFromSuperview()
                secondaryButton.snp.removeConstraints()
                primaryButtonBottomConstraint?.isActive = true
            }
        }
    }
    
    var isEnablePrimaryButton: Bool = true {
        didSet {
            primaryButton.isEnabled = isEnablePrimaryButton
        }
    }
    
    var isEnableSecondaryButton: Bool = true {
        didSet {
            secondaryButton.isEnabled = isEnableSecondaryButton
        }
    }
    
    var primaryButtonText: String? {
        didSet {
            primaryButton.text = primaryButtonText
        }
    }
    
    var secondaryButtonText: String? {
        didSet {
            secondaryButton.text = secondaryButtonText
        }
    }
    
    var primaryAction: (() -> Void)?
    
    var secondaryAction: (() -> Void)?
    
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(primaryButton)
        
        primaryButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            primaryButtonBottomConstraint = make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-3).constraint
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        if isAvailableSecondaryButton {
            insertSecondaryButton()
            primaryButtonBottomConstraint?.isActive = false
        } else {
            primaryButtonBottomConstraint?.isActive = true
        }
    }
    
    private func insertSecondaryButton() {
        guard secondaryButton.superview == nil else {
            return
        }
        
        primaryButtonBottomConstraint?.isActive = false
        
        contentView.addSubview(secondaryButton)
        
        secondaryButton.snp.makeConstraints { make in
            make.top.equalTo(primaryButton.snp.bottom).offset(8)
            make.bottom.equalToSuperview().offset(-3)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
    @objc private func didTapPrimaryButton() {
        primaryAction?()
    }
    
    @objc private func didTapSecondaryButton() {
        secondaryAction?()
    }
}

extension BottomActionsSectionView {
    
    func showIndicationPrimaryButton() {
        primaryButton.showIndication()
    }
    
    func hideIndicationPrimaryButton() {
        primaryButton.hideIndication()
    }
}
