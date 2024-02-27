//
// Copyright © 2023 CF Apps LLC. All rights reserved.
//

import Foundation

struct PaywallPromoViewModel: PaywallViewModel {
    
    let productId: String
    
    let regularPrice: String
    
    let discountPrice: String
    
    let discountPercentage: Int
    
    let expirationDate: Date
}
