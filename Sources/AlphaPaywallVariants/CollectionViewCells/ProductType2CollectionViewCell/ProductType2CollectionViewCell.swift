//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit

final class ProductType2CollectionViewCell: UICollectionViewCell {
    
    static var identifier: String = "ProductType2CollectionViewCell"
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 12
        view.layer.opacity = 0.2
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var borderBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.backgroundColor = .orange
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                borderView.layer.opacity = 1
            } else {
                borderView.layer.opacity = 0.2
            }
        }
    }
    
    private func setupUI() {
        contentView.addSubview(borderBackgroundView)
        contentView.addSubview(borderView)
        
        borderBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        borderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
