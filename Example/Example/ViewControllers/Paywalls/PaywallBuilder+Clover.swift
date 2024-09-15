//
// Copyright © 2024 Alpha Apps LLC. All rights reserved.
//

import UIKit
import PaywallsKit
import PaywallCloverKit

extension PaywallBuilder {
    
    public func makeCloverPaywall() -> PaywallViewController & PaywallViewControllerProtocol {
        return PaywallViewController(
            viewModel: makeViewModel(),
            colorAppearance: makeColorAppearance()
        )
    }
    
    private func makeViewModel() -> PaywallViewModel {
        return PaywallViewModel(
            title: "Start your free 7 day trial",
            termsOfServiceAction: "Terms of Service",
            privacyPolicyAction: "Privacy Policy",
            restoreAction: "Restore Purchases",
            productsAction: "See All Subscriptions",
            options: [
                "7 days free",
                "Save up to 50%"
            ],
            benefits: [
                "Create unlimited clients",
                "Create unlimited documents",
                "Set-up follow-up emails",
                "Build custom reports",
                "Work without ads or limits"
            ],
            detailsText: "7 days free, then $49.99 / year",
            subDetailsText: "That’s only $0.96 / week, billed annually",
            award: PaywallViewModel.AwardItemViewModel(
                title: "It is the go-to mobile invoicing solution for small businesses and freelancers on the move.",
                icon: UIImage(named: "forbes", in: Bundle.main, with: nil)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
            ),
            review: PaywallViewModel.ReviewItemViewModel(
                header: "JOIN THOUSANDS OF OTHERS",
                items: [
                    PaywallViewModel.ReviewItemViewModel.Item(
                        text: "The follow-up email system is particularly impressive—it's automated yet appears very personal to my clients."
                    ),
                    PaywallViewModel.ReviewItemViewModel.Item(
                        text: "As a freelancer managing multiple clients, the ability to create unlimited clients and documents is a game changer."
                    ),
                    PaywallViewModel.ReviewItemViewModel.Item(
                        text: "The follow-up email system is particularly impressive—it's automated yet appears very personal to my clients."
                    ),
                    PaywallViewModel.ReviewItemViewModel.Item(
                        text: "As a small business owner, I appreciate how straightforward it was to set up and generate invoices. Thank you!!!"
                    )
                ]
            ),
            feature: PaywallViewModel.FeatureItemViewModel(
                header: "GREAT FEATURES YOU WILL LOVE",
                title: "Feature",
                basic: "Free",
                premium: "Pro",
                items: [
                    PaywallViewModel.FeatureItemViewModel.Item(
                        text: "Create Documents",
                        isAvailableBasic: true,
                        isAvailablePremium: true
                    ),
                    PaywallViewModel.FeatureItemViewModel.Item(
                        text: "Unlimited Invoices",
                        isAvailableBasic: false,
                        isAvailablePremium: true
                    ),
                    PaywallViewModel.FeatureItemViewModel.Item(
                        text: "Follow-up Reminders",
                        isAvailableBasic: false,
                        isAvailablePremium: true
                    ),
                    PaywallViewModel.FeatureItemViewModel.Item(
                        text: "Custom Templates",
                        isAvailableBasic: false,
                        isAvailablePremium: true
                    ),
                    PaywallViewModel.FeatureItemViewModel.Item(
                        text: "Custom Reports",
                        isAvailableBasic: false,
                        isAvailablePremium: true
                    ),
                    PaywallViewModel.FeatureItemViewModel.Item(
                        text: "Add-Free Experience",
                        isAvailableBasic: false,
                        isAvailablePremium: true
                    ),
                    PaywallViewModel.FeatureItemViewModel.Item(
                        text: "Priority Support",
                        isAvailableBasic: false,
                        isAvailablePremium: true
                    )
                ]
            ),
            help: PaywallViewModel.HelpItemViewModel(
                header: "FREQUENTLY ASKED QUESTIONS",
                items: [
                    PaywallViewModel.HelpItemViewModel.Item(
                        title: "Can I share my subscription with a family member?",
                        subTitle: "Unfortunately, no! Currently, your subscription doesn't extend to any family members linked to your Apple ID. But, we're considering adding this feature in the future."
                    ),
                    PaywallViewModel.HelpItemViewModel.Item(
                        title: "Do subscriptions renew automatically?",
                        subTitle: "All GetInvoice Subscriptions are automatically renewed to ensure constant access for you. If you choose to cancel the automatic renewal, your subscription will expire."
                    ),
                    PaywallViewModel.HelpItemViewModel.Item(
                        title: "How can I cancel subscription?",
                        subTitle: "Open Settings of your iPhone or iPad > Click your Name > Subscriptions > Select GetInvoice > Tap Cancel Subscription."
                    ),
                    PaywallViewModel.HelpItemViewModel.Item(
                        title: "Can I get my money back if I change my mind?",
                        subTitle: "If you’re not satisfied with your subscription, it’s possible to apply for a refund from AppStore. Go to https://reportaproblem.apple.com/. Log in with your Apple ID. Select \"Request a refund\". Select a reason for refund, then select the subscription."
                    )
                ]
            ),
            product: PaywallViewModel.ProductItemViewModel(
                id: "0",
                connectActionText: "CONTINUE!!"
            ),
            products: [
                PaywallViewModel.ProductItemViewModel(
                    id: "1",
                    connectActionText: "Try FREE"
                ),
                PaywallViewModel.ProductItemViewModel(
                    id: "2",
                    connectActionText: "Try FREE"
                ),
                PaywallViewModel.ProductItemViewModel(
                    id: "3",
                    connectActionText: "Try FREE"
                )
            ]
        )
    }
    
    private func makeColorAppearance() -> ColorAppearance {
        return PaywallColorAppearance()
    }
}

private struct PaywallColorAppearance: ColorAppearance {
    
    // MARK: Backgrounds
    
    var systemBackground: UIColor {
        return UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    var secondarySystemBackground: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 0.15)
    }
    var primaryButtonBackground: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    // MARK: Labels
    
    var label: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var secondaryLabel: UIColor {
        return UIColor(red: 0.92, green: 0.92, blue: 0.96, alpha: 0.75)
    }
    
    var tertiaryLabel: UIColor {
        return UIColor(red: 0.92, green: 0.92, blue: 0.96, alpha: 0.3)
    }
    var primaryButtonLabel: UIColor {
        return UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    // MARK: Other
    
    var separator: UIColor {
        return UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 1)
    }
    
    var navigationBarTint: UIColor {
        return UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    var featurePremiumBadgeFill: UIColor {
        return UIColor(red: 1, green: 0.58, blue: 0, alpha: 1)
    }
}
