//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

@MainActor public protocol LongiflorumPaywallDelegate: NSObjectProtocol {
    
    func didSelectProduct(withId id: String)
    
    func didTapContinue()
    
    func didTapTermsOfService()
    
    func didTapPrivacyPolicy()
}
