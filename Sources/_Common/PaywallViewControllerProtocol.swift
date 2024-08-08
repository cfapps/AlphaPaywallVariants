//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

public protocol PaywallViewControllerProtocol: AnyObject {
    
    var delegate: PaywallViewControllerDelegate? { get set }
    
    func showCloseButton(animated: Bool)
    
    func showConnectIndication()
    
    func hideConnectIndication()
    
    func showRestoreIndication()
    
    func hideRestoreIndication()
}

extension PaywallViewControllerProtocol {
    
    public func showConnectIndication() {
        
    }
    
    public func hideConnectIndication() {
        
    }
    
    public func showRestoreIndication() {
        
    }
    
    public func hideRestoreIndication() {
        
    }
}
