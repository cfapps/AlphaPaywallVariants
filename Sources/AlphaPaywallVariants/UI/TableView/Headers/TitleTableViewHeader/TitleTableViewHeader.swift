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
            make.edges.equalToSuperview().inset(16)
        }
    }
}

extension TitleTableViewHeader: QuickTableViewHeaderProtocol {
    
    func update(model: QuickTableViewHeaderModelProtocol) {
        guard let model = model as? TitleTableViewHeaderModel else {
            return
        }
        
        titelLabel.text = model.titleText
        
        textLabelColor = model.textColor
    }
}
