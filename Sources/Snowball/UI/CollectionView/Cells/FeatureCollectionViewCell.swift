//
// Copyright © 2024 Alpha Apps LLC. All rights reserved.
//

import UIKit
import Lottie

final class FeatureCollectionViewCell: UICollectionViewCell {
    
    private lazy var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView()
        animationView.contentMode = .scaleAspectFit
        animationView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        animationView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return animationView
    }()
    
    var animation: Lottie.LottieAnimation? {
        didSet {
            animationView.animation = animation
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(animationView)
        
        animationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func startAnimation() {
        animationView.play(fromProgress: 0, toProgress: 1, loopMode: .loop)
    }
    
    func stopAnimation() {
        animationView.stop()
    }
}
