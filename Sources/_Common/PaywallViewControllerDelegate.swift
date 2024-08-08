//
// Copyright © 2024 CF Apps LLC. All rights reserved.
//

public protocol PaywallViewControllerDelegate: AnyObject {
    
    func didTapClose()
    
    func didTapConnect(productWithId: String)
    
    func didTapRestore()
    
    func didTapPrivacyPolicy()
    
    func didTapTermsOfService()
}
