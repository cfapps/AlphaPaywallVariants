//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

final class AttributedTitleTableViewHeader: UITableViewHeaderFooterView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1, weight: .bold)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.attributedText = nil
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(0)
            make.leading.trailing.equalToSuperview().inset(0)
        }
    }
}

extension AttributedTitleTableViewHeader: QuickTableViewHeaderFooterViewProtocol {
    
    func update(model: QuickTableViewHeaderFooterModelProtocol) {
        guard let model = model as? AttributedTitleTableViewHeaderModel else {
            return
        }
        
        titleLabel.attributedText = model.text
        
        titleLabel.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(model.inset.top)
            make.bottom.equalToSuperview().inset(model.inset.bottom)
            make.leading.equalToSuperview().inset(model.inset.left)
            make.trailing.equalToSuperview().inset(model.inset.right)
        }
    }
}
