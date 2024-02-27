//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import UIKit

final class TipSectionView: UIView {
    
    private lazy var sheildImage: UIImage = {
        var image = UIImage(systemName: "checkmark.shield.fill")
//        image = image?.applyingSymbolConfiguration(
//            font: titleLabel.font,
//            tintColor: UIColor.green
//        )
        return image!
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.font = UIFont.preferredFont(forTextStyle: .footnote, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    
    var text: String? {
        didSet {
            if let text = text, text.count > 0 {
                let attributedText = NSMutableAttributedString()
                attributedText.append(NSAttributedString(
                    attachment: NSTextAttachment(
                        image: sheildImage
                    )
                ))
                attributedText.append(NSAttributedString(string: " "))
                attributedText.append(NSAttributedString(string: text))
                titleLabel.attributedText = attributedText
            } else {
                titleLabel.attributedText = NSAttributedString(string: " ")
            }
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
    }
}
