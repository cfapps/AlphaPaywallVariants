//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import AlphaPaywallsKit

final class ExampleLongiflorumPaywallViewController: LongiflorumPaywallViewController {
    
    override init() {
        super.init()
        
        self.titleText = makeTitle()
        
        self.benefitItems = [
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "person.2")!, text: "Create unlimited clients"),
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "doc.plaintext")!, text: "Create unlimited documents"),
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "envelope.arrow.triangle.branch")!, text: "Set-up follow-up emails"),
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "chart.line.uptrend.xyaxis")!, text: "Build custom reports"),
            LongiflorumPaywallViewController.BenefitItemViewModel(image: UIImage(systemName: "checkmark.seal")!, text: "Work without ads or limits"),
        ]
        self.productItems = [
            Self.ProductItemViewModel(
                id: "1",
                title: "Monthly",
                description: "First 7 days free.\n$9.99 / month",
                details: "Get Premium with a Free 7-day Trial\nthen 59.99/month. No commitment. Cancel anytime."
            ),
            Self.ProductItemViewModel(
                id: "2",
                title: "Annual",
                description: "First 7 days free.\n$9.99 / month",
                details: "Get Premium with a Free 7-day Trial\nthen 59.99/year. No commitment. Cancel anytime."
            )
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeTitle() -> NSAttributedString {
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
}
