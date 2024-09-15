//
// // Copyright © 2024 Alpha Apps LLC. All rights reserved.
//

import UIKit
import PaywallsKit
import PaywallSnowballKit

extension PaywallBuilder {
    
    public func makeShowballPaywall() -> UIViewController & PaywallViewControllerProtocol {
        return PaywallViewController(
            viewModel: makeViewModel(),
            colorAppearance: PaywallColorAppearance()
        )
    }
    
    private func makeViewModel() -> PaywallViewModel {
        return PaywallViewModel(
            name: "Invoices PROOOOO",
            termsOfServiceAction: "Terms of Service",
            privacyPolicyAction: "Privacy Policy",
            restoreAction: "Restore",
            benefit: PaywallViewModel.Benefit(
                items: [
                    PaywallViewModel.Benefit.Item(title: "Create Unlimited Documents", image: UIImage(named: "snowball.slide.documents", in: Bundle.main, with: nil)),
                    PaywallViewModel.Benefit.Item(title: "Create Unlimited Clients", image: UIImage(named: "snowball.slide.clients", in: Bundle.main, with: nil)),
                    PaywallViewModel.Benefit.Item(title: "Set-Up Follow-Up Emails", image: UIImage(named: "snowball.slide.form", in: Bundle.main, with: nil)),
                    PaywallViewModel.Benefit.Item(title: "Build Custom Reports", image: UIImage(named: "snowball.slide.reports", in: Bundle.main, with: nil))
                ]
            ),
            award: PaywallViewModel.AwardItemViewModel(
                title: "It is the go-to mobile invoicing solution for small businesses and freelancers on the move.",
                icon: UIImage(named: "forbes", in: Bundle.main, with: nil)?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
            ),
            reviewsHeader: "Trusted by Thousands",
            reviews: [
                PaywallViewModel.ReviewItemViewModel(
                    image: UIImage(named: "review.1"),
                    name: "Sarah0408C",
                    text: "I've used many invoicing apps, but this one has been my favorite so far."
                ),
                PaywallViewModel.ReviewItemViewModel(
                    image: UIImage(named: "review.2"),
                    name: "Oliver1989",
                    text: "As a freelancer managing multiple clients, the ability to create unlimited clients and documents is a game changer. "
                ),
                PaywallViewModel.ReviewItemViewModel(
                    image: UIImage(named: "review.3"),
                    name: "AnaMorales0843",
                    text: "The follow-up email system is particularly impressive—it's automated yet appears very personal to my clients."
                ),
                PaywallViewModel.ReviewItemViewModel(
                    image: UIImage(named: "review.4"),
                    name: "AlexaJ_1990S",
                    text: "The custom report builder is robust, providing all the data I need at my fingertips."
                ),
                PaywallViewModel.ReviewItemViewModel(
                    image: UIImage(named: "review.5"),
                    name: "TechGeek91",
                    text: "As a small business owner, I appreciate how straightforward it was to set up and generate invoices. Thank you for simplifying the process for us."
                ),
            ],
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
                header: "Frequently Asked Questions",
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
                items: [
                    PaywallViewModel.ProductItemViewModel.Item(
                        id: "1",
                        title: "Unlimited Annual",
                        subTitle: "Unlimited access to all features for an entire year—perfect for high-volume users.",
                        detailsTitle: "BEST VALUE",
                        detailsSubTitle: "7-DAYS FREE TRIAL",
                        price: "$3.99",
                        priceDuration: "month",
                        priceSubTitle: "$47.99 billed annually",
                        priceDescription: "SAVE 75%",
                        options: [
                            PaywallViewModel.ProductItemViewModel.Option(image: UIImage(named: "crown.17.medium"), text: "Our most popular plan"),
                            PaywallViewModel.ProductItemViewModel.Option(image: UIImage(named: "infinity.17.medium"), text: "Unlimited features"),
                            PaywallViewModel.ProductItemViewModel.Option(image: UIImage(named: "calendar.badge.clock.17.medium"), text: "Cancel anytime")
                        ],
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
                        title: "Pay-As-You-Go",
                        subTitle: "Flexibility to pay only for what you use, ideal for occasional invoicing.",
                        detailsTitle: "MOST FLEXIBLE",
                        detailsSubTitle: "3-DAYS FREE TRIAL",
                        price: "$3.99",
                        priceDuration: "week",
                        priceSubTitle: "Billed weekly",
                        priceDescription: "",
                        options: [
                            PaywallViewModel.ProductItemViewModel.Option(image: UIImage(named: "calendar.badge.clock.17.medium"), text: "Cancel anytime")
                        ],
                        descriptionHeader: "",
                        descriptionItems: [],
                        action: "Get Weekly"
                    ),
                    PaywallViewModel.ProductItemViewModel.Item(
                        id: "3",
                        title: "Lifetime",
                        subTitle: "One-time purchase for lifetime access, the ultimate convenience in invoicing solutions.",
                        detailsTitle: "PAY ONCE",
                        detailsSubTitle: "",
                        price: "$139.99",
                        priceDuration: "",
                        priceSubTitle: "One-time purchase",
                        priceDescription: "",
                        options: [
                            PaywallViewModel.ProductItemViewModel.Option(image: UIImage(named: "star.17.medium"), text: "No subscription"),
                            PaywallViewModel.ProductItemViewModel.Option(image: UIImage(named: "infinity.17.medium"), text: "Unlimited features")
                        ],
                        descriptionHeader: "",
                        descriptionItems: [],
                        action: "Get Lifetime"
                    )
                ],
                selectedItemId: "2"
            )
        )
    }
}

private struct PaywallColorAppearance: ColorAppearance {
    
    // MARK: Backgrounds
    
    var systemBackground: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var secondarySystemBackground: UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.9)
    }
    
    var tertiarySystemBackground: UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.9)
    }
    
    // MARK: Backgrounds
    
    var label: UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    var secondaryLabel: UIColor {
        return UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 0.6)
    }
    
    var tertiaryLabel: UIColor {
        return UIColor(red: 0.92, green: 0.92, blue: 0.96, alpha: 0.3)
    }
    
    var quaternaryLabel: UIColor {
        return UIColor.orange
    }
    
    var accentLabel: UIColor {
        return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    var invertPrimaryLabel: UIColor {
        return UIColor.white
    }
    
    // MARK: Additional
    
    var accent: UIColor {
        return UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    var navigationBarTint: UIColor {
        return UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
    }
    
    var separator: UIColor {
        return UIColor(red: 0.24, green: 0.24, blue: 0.26, alpha: 1)
    }
}
