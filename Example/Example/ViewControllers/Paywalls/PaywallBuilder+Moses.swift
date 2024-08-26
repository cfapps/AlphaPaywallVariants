//
// // Copyright © 2024 Alpha Apps LLC. All rights reserved.
//

import UIKit
import PaywallsKit
import PaywallMosesKit

extension PaywallBuilder {
    
    public func makeMosesPaywall() -> UIViewController & PaywallViewControllerProtocol {
        return PaywallViewController(
            viewModel: makeViewModel(),
            colorAppearance: PaywallColorAppearance()
        )
    }
    
    private func makeViewModel() -> PaywallViewModel {
        return PaywallViewModel(
            title: "Get Invoice *Pro*",
            subTitle: "Unlock the ultimate convenience in invoicing solutions",
            headerImage: UIImage(named: "logo.documents"),
            termsOfServiceAction: "Terms of Service",
            privacyPolicyAction: "Privacy Policy",
            restoreAction: "Restore",
            award: PaywallViewModel.AwardItemViewModel(
                title: "It is the go-to mobile invoicing solution for small businesses and freelancers on the move.",
                icon: UIImage(named: "forbes", in: Bundle.main, with: nil)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
            ),
            reviewsHeader: "Trusted by Thousands",
            review: PaywallViewModel.ReviewItemViewModel(
                items: [
                    PaywallViewModel.ReviewItemViewModel.Item(
                        image: UIImage(named: "review.1"),
                        name: "Sarah0408C",
                        title: "Amazing invoicing app",
                        body: "I've used many invoicing apps, but this one has been my favorite so far."
                    ),
                    PaywallViewModel.ReviewItemViewModel.Item(
                        image: UIImage(named: "review.2"),
                        name: "Oliver1989",
                        title: "A game changer",
                        body: "As a freelancer managing multiple clients, the ability to create unlimited clients and documents is a game changer. "
                    ),
                    PaywallViewModel.ReviewItemViewModel.Item(
                        image: UIImage(named: "review.3"),
                        name: "AnaMorales0843",
                        title: "Saves so much time",
                        body: "The follow-up email system is particularly impressive—it's automated yet appears very personal to my clients."
                    ),
                    PaywallViewModel.ReviewItemViewModel.Item(
                        image: UIImage(named: "review.4"),
                        name: "AlexaJ_1990S",
                        title: "Best reports",
                        body: "The custom report builder is robust, providing all the data I need at my fingertips."
                    ),
                    PaywallViewModel.ReviewItemViewModel.Item(
                        image: UIImage(named: "review.5"),
                        name: "TechGeek91",
                        title: "Just perfect!!",
                        body: "As a small business owner, I appreciate how straightforward it was to set up and generate invoices. Thank you for simplifying the process for us."
                    ),
                ]
            ),
            featureHeader: "GREAT FEATURES YOU WILL LOVE",
            feature: PaywallViewModel.FeatureItemViewModel(
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
            helpHeader: "Frequently Asked Questions",
            help: PaywallViewModel.HelpItemViewModel(
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
            benefit: PaywallViewModel.BenefitItemViewModel(
                items: [
                    PaywallViewModel.BenefitItemViewModel.Item(
                        icon: UIImage(named: "person.fill.badge.plus.20.regular", in: Bundle.main, with: nil),
                        title: "Create unlimited clients"
                    ),
                    PaywallViewModel.BenefitItemViewModel.Item(
                        icon: UIImage(named: "append.page.fill.20.regular", in: Bundle.main, with: nil),
                        title: "Create unlimited documents"
                    ),
                    PaywallViewModel.BenefitItemViewModel.Item(
                        icon: UIImage(named: "envelope.fill.20.regular", in: Bundle.main, with: nil),
                        title: "Set-up follow-up emails"
                    ),
                    PaywallViewModel.BenefitItemViewModel.Item(
                        icon: UIImage(named: "chart.pie.fill.20.regular", in: Bundle.main, with: nil),
                        title: "Build custom reports"
                    ),
                ]
            ),
            productHeader: "Pick a Plan That Suits You",
            product: PaywallViewModel.ProductItemViewModel(
                items: [
                    PaywallViewModel.ProductItemViewModel.Item(
                        id: "1",
                        title: "Monthly",
                        price: "$9.99",
                        priceDetails: "$9.99",
                        priceDescription: "Billed Monthly",
                        description: "No commitment. Cancel anytime.",
                        option: PaywallViewModel.ProductItemViewModel.Option(
                            color: UIColor.red,
                            textColor: UIColor.white,
                            text: "Popular"
                        ),
                        descriptionHeader: "How Your Free Trial Works",
                        descriptionItems: [
                            PaywallViewModel.ProductItemViewModel.Description(
                                icon: UIImage(named: "infinity.20.regular"),
                                title: "Today: Get Instant Access",
                                subTitle: "Get Invoice Pro free for 7 days with the annual subscription."
                            ),
                            PaywallViewModel.ProductItemViewModel.Description(
                                icon: UIImage(named: "bell.fill.20.regular"),
                                title: "Day 5: Trial Reminder",
                                subTitle: "We'll send you a notification reminder that your trial is ending."
                            ),
                            PaywallViewModel.ProductItemViewModel.Description(
                                icon: UIImage(named: "calendar.badge.checkmark.20.regular"),
                                title: "Day 7: Trial Ends",
                                subTitle: "Trial ends. You will be billed for one year unless you cancel before this date."
                            ),
                        ],
                        action: "Continue"
                    ),
                    PaywallViewModel.ProductItemViewModel.Item(
                        id: "2",
                        title: "Yearly",
                        price: "$49.99",
                        priceDetails: "Only $0.96 / week",
                        priceDescription: "􀑊 Free 1 Week Trial",
                        description: "No commitment. Cancel anytime.",
                        option: PaywallViewModel.ProductItemViewModel.Option(
                            color: UIColor.green,
                            textColor: UIColor.white,
                            text: "Save 58%"
                        ),
                        descriptionHeader: nil,
                        descriptionItems: nil,
                        action: "Continue"
                    ),
                    PaywallViewModel.ProductItemViewModel.Item(
                        id: "3",
                        title: "Monthly",
                        price: "$9.99",
                        priceDetails: "$9.99",
                        priceDescription: "Billed Monthly",
                        description: "No commitment.",
                        option: nil,
                        descriptionHeader: "How Your Free Trial Works",
                        descriptionItems: [
                            PaywallViewModel.ProductItemViewModel.Description(
                                icon: UIImage(named: "infinity.20.regular"),
                                title: "Today: Get Instant Access",
                                subTitle: "Get Invoice Pro free for 7 days with the annual subscription."
                            ),
                            PaywallViewModel.ProductItemViewModel.Description(
                                icon: UIImage(named: "bell.fill.20.regular"),
                                title: "Day 5: Trial Reminder",
                                subTitle: "We'll send you a notification reminder that your trial is ending."
                            ),
                            PaywallViewModel.ProductItemViewModel.Description(
                                icon: UIImage(named: "calendar.badge.checkmark.20.regular"),
                                title: "Day 7: Trial Ends",
                                subTitle: "Trial ends. You will be billed for one year unless you cancel before this date."
                            ),
                        ],
                        action: "Continue"
                    ),
                ],
                selectedItemId: "1"
            )
        )
    }
}

private struct PaywallColorAppearance: ColorAppearance {
    
    var systemBackground: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var secondarySystemBackground: UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.9)
    }
    
    var tertiarySystemBackground: UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.9)
    }
    
    var label: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    var secondaryLabel: UIColor {
        return UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.6)
    }
    
    var tertiaryLabel: UIColor {
        return UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.18)
    }
    
    var quaternaryLabel: UIColor {
        return UIColor.orange
    }
    
    var accentLabel: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var separator: UIColor {
        return UIColor(red: 0.47, green: 0.47, blue: 0.5, alpha: 0.2)
    }
    
    var accent: UIColor {
        return UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    var navigationBarTint: UIColor {
        return UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    var titleLabel: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var primaryButtonFill: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var primaryButtonLabel: UIColor {
        return UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    var featureBasicBadgeFill: UIColor {
        return UIColor.clear
    }
    
    var featureBasicBadgeLabel: UIColor {
        return UIColor.white
    }
    
    var featurePremiumBadgeFill: UIColor {
        return UIColor.clear
    }
    
    var featurePremiumBadgeLabel: UIColor {
        return UIColor.white
    }
}
