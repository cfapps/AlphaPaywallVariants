//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class TitleTableViewHeader: UITableViewHeaderFooterView {
    
    var textLabelColor: UIColor = UIColor.label {
        didSet {
            titelLabel.textColor = textLabelColor
        }
    }
    
    var containerInsets: UIEdgeInsets = .zero {
        didSet {
            titelLabel.snp.updateConstraints { make in
                make.leading.equalToSuperview().inset(containerInsets.left)
                make.trailing.equalToSuperview().inset(containerInsets.right)
                make.top.equalToSuperview().inset(containerInsets.top)
                make.bottom.equalToSuperview().inset(containerInsets.bottom)
            }
        }
    }
    
    private lazy var titelLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title2, weight: .bold)
        label.textColor = textLabelColor
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titelLabel)
        
        titelLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(0)
            make.trailing.equalToSuperview().inset(0)
            make.top.equalToSuperview().inset(0)
            make.bottom.equalToSuperview().inset(0)
        }
    }
}

extension TitleTableViewHeader: QuickTableViewHeaderFooterViewProtocol {
    
    func update(model: QuickTableViewHeaderFooterModelProtocol) {
        guard let model = model as? TitleTableViewHeaderModel else {
            return
        }
        
        titelLabel.text = model.titleText
        textLabelColor = model.textColor
        containerInsets = model.insets
    }
}
