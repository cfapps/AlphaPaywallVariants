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
                description: "First 7 days free.",
                details: "Get Premium with a Free 7-day Trial\nthen 59.99/month. No commitment. Cancel anytime."
            ),
            Self.ProductItemViewModel(
                id: "2",
                title: "Annual",
                description: "First 7 days free.\n$9.99 / month",
                details: "Get Premium with a Free 7-day Trial\nthen 59.99/year. No commitment. Cancel anytime."
            ),
            Self.ProductItemViewModel(
                id: "3",
                title: "Lifetie",
                description: "First 7 days free.\n$9.99 / month",
                details: "One time payment."
            )
        ]
        self.selectedProductId = "2"
        
        self.setContinueButton(text: "Start My Free Trial")
        self.termsOfServiceButtonText = "Terms Of Service"
        self.privacyPolicyButtonText = "Privacy Policy"
        
        self.awardItem = Self.AwardItemViewModel(
            title: "Trusted by 10,000 Businesses Worldwide. Boost Your Business Growth with Get Invoice",
            subTitle: "Featured in 12 countries",
            details: "Apps for\nSmall Business"
        )
        
        self.features = FeaturesItemViewModel(
            titleText: "Great Features You will Love",
            nameHeaderText: "Feature",
            noSubscriptionHeaderText: "FREE",
            withSubscriptionHeaderText: "PRO",
            items: [
                "Unlimited Invoices",
                "Follow-up Reminders",
                "Custom Templates",
                "Custom Reports",
                "Add-Free Experience",
                "Priority Support"
            ]
        )
        
        self.reviewSection = Self.ReviewsItemViewModel(
            titleText: "Trusted by Thousands",
            items: [
                Self.ReviewsItemViewModel.Item(
                    name: "HandyMatt",
                    title: "Amazing Invoicing App",
                    body: "I've been able to organize my clients and documents and get paid faster"
                ),
                Self.ReviewsItemViewModel.Item(
                    name: "NYPlumber07",
                    title: "I am happy",
                    body: "As a small business owner, I appreciate how straightforward it was to set up and generate invoices. Thank you for simplifying the process for us"
                ),
                Self.ReviewsItemViewModel.Item(
                    name: "BigMikeLA",
                    title: "Love this app!!",
                    body: "This is an excellent application for invoice creation. Ease of use and significantly simplifies my workflow"
                )
            ]
        )
        
        self.helpSection = Self.HelpSectionItemViewModel(
            title: "Most Asked Questions",
            items: [
                .init(
                    question: "Can I share my subscription with a family member?",
                    answer: "Yes, absolutely! Your subscription will be automatically shared with everyone you’ve shared your Apple ID account."
                ),
                .init(
                    question: "Do subscriptions renew automatically?",
                    answer: "All GetInvoice Subscriptions are automatically renewed to ensure constant access for you. If you choose to cancel the automatic renewal, your subscription will expire."
                ),
                .init(
                    question: "How can I cancel subscription?",
                    answer: "Open Settings of your iPhone or iPad > Click your Name > Subscriptions > Select GetInvoice > Tap Cancel Subscription."
                ),
                .init(
                    question: "Can i get my money back if i change my mind?",
                    answer: "If you’re not satisfied with your subscription, it’s possible to apply for a refund from AppStore. Go to https://reportaproblem.apple.com/. Log in with your Apple ID. Select \"Request a refund\". Select a reason for refund, then select the subscription."
                )
            ]
        )
        
        self.disclamerSection = Self.DisclamerItemViewModel(
            iconSystemName: "checkmark.shield.fill",
            iconColor: UIColor.systemGreen,
            text: "No payments now"
        )
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
