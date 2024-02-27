//
// Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

public protocol PaywallViewControllerDelegate: AnyObject {
    
    func didTapTermsOfService()
    
    func didTapPrivacyPolicy()
    
    func didTapConnect(productWithId: String)
}
