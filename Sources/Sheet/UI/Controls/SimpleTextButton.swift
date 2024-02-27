//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import UIKit

public final class SimpleTextButton: UIControl {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = backgroundContentColor
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline, weight: .semibold)
        label.textColor = textColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    private lazy var indicationView: UIActivityIndicatorView = {
        let indicationView = UIActivityIndicatorView()
        indicationView.color = textColor
        return indicationView
    }()
    
    public var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    public var textColor: UIColor = UIColor.label {
        didSet {
            textLabel.textColor = textColor
            indicationView.color = textColor
        }
    }
    
    public var backgroundContentColor: UIColor = UIColor.clear {
        didSet {
            backgroundView.backgroundColor = backgroundContentColor
        }
    }
    
    public var contentInset: UIEdgeInsets = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 16) {
        didSet {
            textLabel.snp.updateConstraints { make in
                make.top.equalToSuperview().inset(contentInset.top)
                make.bottom.equalToSuperview().inset(contentInset.bottom)
                make.leading.equalToSuperview().inset(contentInset.left)
                make.trailing.equalToSuperview().inset(contentInset.right)
            }
        }
    }
    
    public init() {
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var isHighlighted: Bool {
        didSet {
            updateHighliteState()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            updateHighliteState()
        }
    }
    
    public func showIndication() {
        isEnabled = false
        textLabel.isHidden = true
        if indicationView.superview == nil {
            addSubview(indicationView)
            indicationView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            indicationView.startAnimating()
        }
    }
    
    public func hideIndication() {
        isEnabled = true
        textLabel.isHidden = false
        if indicationView.superview != nil {
            indicationView.snp.removeConstraints()
            indicationView.stopAnimating()
            indicationView.removeFromSuperview()
        }
    }
    
    private func setupUI() {
        addSubview(backgroundView)
        addSubview(textLabel)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(contentInset.top)
            make.bottom.equalToSuperview().inset(contentInset.bottom)
            make.leading.equalToSuperview().inset(contentInset.left)
            make.trailing.equalToSuperview().inset(contentInset.right)
        }
    }
    
    private func updateHighliteState() {
        textLabel.textColor = resolveTextColor(isEnabled, isHighlighted)
        backgroundView.backgroundColor = resolveBackgroundContentColor(isEnabled, isHighlighted)
    }
    
    private func resolveTextColor(_ isEnabled: Bool, _ isHighlighted: Bool) -> UIColor {
        if !isEnabled {
            return textColor.withAlphaComponent(0.5)
        } else if isHighlighted {
            return textColor.withAlphaComponent(0.7)
        }
        
        return textColor
    }
    
    private func resolveBackgroundContentColor(_ isEnabled: Bool, _ isHighlighted: Bool) -> UIColor {
        guard backgroundContentColor != UIColor.clear else {
            return UIColor.clear
        }
        
        if !isEnabled {
            return backgroundContentColor.withAlphaComponent(0.5)
        } else if isHighlighted {
            return backgroundContentColor.withAlphaComponent(0.7)
        }
        
        return backgroundContentColor
    }
}
