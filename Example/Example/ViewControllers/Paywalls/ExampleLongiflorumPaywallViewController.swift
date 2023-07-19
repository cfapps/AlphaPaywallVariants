//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import AlphaPaywallsKit

final class ExampleLongiflorumPaywallViewController: LongiflorumPaywallViewController {
    
    override var titleText: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "Create Unlimited Invoices with ")
        let highlitedString = NSAttributedString(string: "Premium Subscription")
        attributedString.append(highlitedString)
        
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.systemBlue,
            range: NSRange(location: attributedString.length - highlitedString.length, length: highlitedString.length)
        )
        
        return attributedString
    }
    
    override var benefitItems: [LongiflorumPaywallViewController.BenefitItemViewModel] {
        return [
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "person.2")!, text: "Create unlimited clients"),
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "doc.plaintext")!, text: "Create unlimited documents"),
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "envelope.arrow.triangle.branch")!, text: "Set-up follow-up emails"),
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "chart.line.uptrend.xyaxis")!, text: "Build custom reports"),
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "checkmark.seal")!, text: "Work without ads or limits"),
        ]
    }
    
    public convenience init() {
        self.init(
            products: [
                Self.ProductItemViewModel(id: "1", title: "Monthly", description: "None", details: "Details"),
                Self.ProductItemViewModel(id: "2", title: "Annyal", description: "None 2", details: "Details 2")
            ],
            selectedProductId: "2"
        )
    }
}
