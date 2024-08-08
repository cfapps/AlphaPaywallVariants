//
// Copyright © 2024 Alpha Apps LLC. All rights reserved.
//

import UIKit
import PaywallsKit
import PaywallCloverKit

final class PresentPaywallViewController: UIViewController {
    
    private var variant: Variant
    
    private var viewController: (UIViewController & PaywallViewControllerProtocol)?
    
    init(with variant: Variant) {
        self.variant = variant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        let viewController = variant.viewController
        viewController.showCloseButton(animated: false )
        viewController.delegate = self
        let nvc = UINavigationController(rootViewController: viewController)
        
        self.viewController = viewController
        
        addChild(nvc)
        view.addSubview(nvc.view)
        viewController.didMove(toParent: self)
    }
}

extension PresentPaywallViewController: PaywallViewControllerDelegate {
    
    func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapConnect(productWithId: String) {
        viewController?.showConnectIndication()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewController?.hideConnectIndication()
        }
    }
    
    func didTapRestore() {
        viewController?.showRestoreIndication()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewController?.hideRestoreIndication()
        }
    }
    
    func didTapPrivacyPolicy() {
        
    }
    
    func didTapTermsOfService() {
        
    }
}
