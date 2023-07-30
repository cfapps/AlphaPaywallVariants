//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import AlphaPaywallsKit

final class ExampleLongiflorumPaywallViewController: LongiflorumPaywallViewController {
    
    override init() {
        super.init()
        
        self.dataSource = self
        self.delegate = self
        self.privacyPolicyButtonText = "Privacy Policy"
        self.termsOfServiceButtonText = "Terms of Service"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExampleLongiflorumPaywallViewController: LongiflorumPaywallDataSource {
    
    func getTitle() -> NSAttributedString {
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
    
    func getTitle() -> String {
        return "Subscription"
    }
    
    func getProductSection() -> LongiflorumPaywallViewController.ProductsItemViewModel {
        return .init(
            items: [
                .init(
                    id: "1",
                    title: "Monthly",
                    description: "First 7 days free.\n$9.99 / month",
                    details: "Get Premium with a Free 7-day Trial\nthen 19.99/month. No commitment. Cancel anytime.",
                    badge: nil
                ),
                .init(
                    id: "2",
                    title: "Yearly",
                    description: "First 7 days free.\n$59.99/year",
                    details: "Get Premium with a Free 7-day Trial\nthen 59.99/year. No commitment. Cancel anytime.",
                    badge: .init(
                        text: "Save 50%",
                        color: UIColor.systemBlue,
                        textColor: UIColor.white
                    )
                ),
                .init(
                    id: "3",
                    title: "Yearly",
                    description: "First 7 days free.\n$59.99/year",
                    details: "Get Premium with a Free 7-day Trial\nthen 59.99/year. No commitment. Cancel anytime.",
                    badge: nil
                )
            ],
            selectedItemId: "2"
        )
    }
    
    func getBenefitSection() -> LongiflorumPaywallViewController.BenefitsItemViewModel {
        func getImage(_ name: String) -> UIImage {
            return UIImage(systemName: name)!
                .applyingSymbolConfiguration(imgConfig)!
                .withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        }
        
        let imgConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20, weight: .bold))
        
        return .init(items: [
            .init(
                image: getImage("person.2"),
                text: "Create unlimited clients"
            ),
            .init(
                image: getImage("doc.plaintext"),
                text: "Create unlimited documents"
            ),
            .init(
                image: getImage("envelope.arrow.triangle.branch"),
                text: "Set-up follow-up emails"
            ),
            .init(
                image: getImage("chart.line.uptrend.xyaxis"),
                text: "Build custom reports"
            ),
            .init(
                image: getImage("checkmark.seal"),
                text: "Work without ads or limits"
            )
        ])
    }
    
    func getAwardSection() -> LongiflorumPaywallViewController.AwardItemViewModel? {
        return .init(
            title: "Trusted by 10,000 Businesses Worldwide. Boost Your Business Growth with Get Invoice",
            subTitle: "Featured in 12 countries",
            details: "Apps for\nSmall Business"
        )
    }
    
    func getFeatureSection() -> LongiflorumPaywallViewController.FeaturesItemViewModel? {
        return .init(
            titleText: "Great Features You will Love",
            nameHeaderText: "Feature",
            noSubscriptionHeaderText: "Free",
            withSubscriptionHeaderText: "Pro",
            items: [
                "Unlimited Invoices",
                "Follow-up Reminders",
                "Custom Templates",
                "Custom Reports",
                "Add-Free Experience",
                "Priority Support"
            ]
        )
    }
    
    func getReviewSection() -> LongiflorumPaywallViewController.ReviewsItemViewModel? {
        return .init(
            titleText: "Trusted by Thousands",
            items: [
                .init(
                    name: "HandyMatt",
                    subject: "Amazing Invoicing App",
                    body: "I've been able to organize my clients and documents and get paid faster"
                ),
                .init(
                    name: "NYPlumber07",
                    subject: "I am happy",
                    body: "As a small business owner, I appreciate how straightforward it was to set up and generate invoices. Thank you for simplifying the process for us"
                ),
                .init(
                    name: "BigMikeLA",
                    subject: "Love this app!!",
                    body: "This is an excellent application for invoice creation. Ease of use and significantly simplifies my workflow"
                )
            ]
        )
    }
    
    func getHelpSection() -> LongiflorumPaywallViewController.HelpSectionItemViewModel? {
        return .init(
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
    }
    
    func getTodoSection(forProduct id: String) -> LongiflorumPaywallViewController.TodosItemViewModel? {
        if id == "1" {
            return .init(
                titleText: "What Happens Next",
                items: [
                    .init(
                        iconName: "bolt.fill",
                        titleText: "Today",
                        subTitleText: "Unlock instant access to explore how GetInvoice can revolutionize your business operations."
                    ),
                    .init(
                        iconName: "bell.fill",
                        titleText: "Day 5",
                        subTitleText: "We'll send you a friendly email and notification reminder before your trial ends."
                    ),
                    .init(
                        iconName: "staroflife.fill",
                        titleText: "Day 7",
                        subTitleText: "You’ll be charged on July 18. Feel free to cancel at any time prior to this date."
                    )
                ]
            )
        } else if id == "2" {
            return .init(
                titleText: "What Happens Next 2",
                items: [
                    .init(
                        iconName: "bolt.fill",
                        titleText: "Today 2",
                        subTitleText: "Unlock instant access to explore how GetInvoice can revolutionize your business operations."
                    ),
                    .init(
                        iconName: "bell.fill",
                        titleText: "Day 99",
                        subTitleText: "We'll send you a friendly email and notification reminder before your trial ends."
                    ),
                    .init(
                        iconName: "staroflife.fill",
                        titleText: "Day 1479",
                        subTitleText: "You’ll be charged on July 18. Feel free to cancel at any time prior to this date."
                    )
                ]
            )
        } else {
            return nil
        }
    }
    
    func getDisclamerSection(forProduct id: String) -> LongiflorumPaywallViewController.DisclamerItemViewModel? {
        if id == "1" {
            return .init(
                iconSystemName: "checkmark.shield.fill",
                iconColor: UIColor.systemGreen,
                text: "No payments now"
            )
        } else if id == "2" {
            return .init(
                iconSystemName: "checkmark.shield.fill",
                iconColor: UIColor.systemGreen,
                text: "With payments now"
            )
        } else {
            return nil
        }
    }
    
    func getContinueButtonText(forProduct id: String) -> String {
        return "Start My Free Trial"
    }
}

extension ExampleLongiflorumPaywallViewController: LongiflorumPaywallDelegate {
    
    func didSelectProduct(withId id: String) {
        
    }
    
    func didTapContinue() {
        self.setContent(isEnable: false)
        self.setContinueButton(isIndicating: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.setContent(isEnable: true)
            self.setContinueButton(isIndicating: false)
        }
    }
    
    func didTapTermsOfService() {
        
    }
    
    func didTapPrivacyPolicy() {
        
    }
}
