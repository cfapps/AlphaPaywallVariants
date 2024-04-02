//
// // Copyright © 2024 Alpha Apps LLC. All rights reserved.
//

import UIKit
import AlphaPaywallSheet

final class ExampleSheetPaywallViewController: SheetPaywallViewController {
    
    private lazy var closeBarButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: "Close",
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(didTapClose)
        )
    }()
    
    // MARK: Apperance
    
    init() {
        super.init(
            appearance: Appearance(),
            viewModel: PaywallDefaultViewModel(
                title: "Hello my *Paywall* title",
                products: PaywallDefaultViewModel.ProductViewModel(
                    items: [
                        PaywallDefaultViewModel.ProductViewModel.Item(
                            id: "1",
                            title: "Title",
                            description: "Description",
                            details: "Details 11",
                            actionText: "Apply me",
                            badge: nil,
                            stepsText: "STEPS",
                            steps: [
                                PaywallDefaultViewModel.ProductViewModel.Item.Step(title: "Title", subTitle: "SubTitle"),
                                PaywallDefaultViewModel.ProductViewModel.Item.Step(title: "Title", subTitle: "SubTitle"),
                                PaywallDefaultViewModel.ProductViewModel.Item.Step(title: "Title", subTitle: "SubTitle")
                            ],
                            disclamer: "disclamer"
                        ),
                        PaywallDefaultViewModel.ProductViewModel.Item(
                            id: "2",
                            title: "Title",
                            description: "Description",
                            details: "Details",
                            actionText: "Action",
                            badge: PaywallDefaultViewModel.ProductViewModel.Item.Badge.benefit("BE"),
                            stepsText: nil,
                            steps: [],
                            disclamer: "disclamer"
                        ),
                        PaywallDefaultViewModel.ProductViewModel.Item(
                            id: "3",
                            title: "Title",
                            description: "Description",
                            details: "Details",
                            actionText: "Action",
                            badge: PaywallDefaultViewModel.ProductViewModel.Item.Badge.text("BE"),
                            stepsText: "STEPS 2",
                            steps: [
                                PaywallDefaultViewModel.ProductViewModel.Item.Step(title: "Title", subTitle: "SubTitle"),
                                PaywallDefaultViewModel.ProductViewModel.Item.Step(title: "Title", subTitle: "SubTitle")
                            ],
                            disclamer: nil
                        )
                    ],
                    selectedItemId: "2"
                ),
                benefits: PaywallDefaultViewModel.BenefitViewModel(
                    items: [
                        PaywallDefaultViewModel.BenefitViewModel.Item(icon: .clients ,titleText: "asdad"),
                        PaywallDefaultViewModel.BenefitViewModel.Item(icon: .reminders, titleText: "kJKJHkjhkjashkajshd")
                    ]
                ),
                questions: PaywallDefaultViewModel.QuestionViewModel(
                    title: "Question & Answer",
                    items: [
                        PaywallDefaultViewModel.QuestionViewModel.Item(questionText: "Question?", answerText: "Answer !")
                    ]
                ),
                reviews: PaywallDefaultViewModel.ReviewViewModel(
                    title: "ReviewS",
                    items: [
                        PaywallDefaultViewModel.ReviewViewModel.Item(
                            name: "John",
                            subject: "Title",
                            body: "Description boduy"
                        )
                    ]
                ),
                feature: PaywallDefaultViewModel.FeatureViewModel(
                    title: "Feature",
                    name: "Name",
                    positive: "Positive",
                    negative: "Negative",
                    items: [
                        PaywallDefaultViewModel.FeatureViewModel.Item(
                            name: "Feature 1"
                        ),
                        PaywallDefaultViewModel.FeatureViewModel.Item(
                            name: "Feature 2"
                        ),
                        PaywallDefaultViewModel.FeatureViewModel.Item(
                            name: "Feature 3"
                        )
                    ]
                ),
                termsOfServiceText: "Terms Of Service",
                privacyPolicyText: "Privacy Policy"
            )
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = closeBarButton
    }
    
    @objc private func didTapClose() {
        self.dismiss(animated: true)
    }
}

extension ExampleSheetPaywallViewController {
    
    private struct Appearance: SheetPaywallViewControllerAppearance {
        
        var accentColor: UIColor {
            return UIColor.orange
        }
        
        var labelColor: UIColor {
            return .yellow
        }
        
        var secondaryLabelColor: UIColor {
            return .green
        }
        
        var primaryActionLabelColor: UIColor {
            return .systemPink
        }
        
        var primaryActionBackgroundColor: UIColor {
            return .brown
        }
        
        var compareCheckedColor: UIColor {
            return .red
        }
        
        var compareUncheckedColor: UIColor {
            return .brown
        }
        
        var compareBackgroundColor: UIColor {
            return UIColor.red.withAlphaComponent(0.05)
        }
        
        var reviewTitleLabelColor: UIColor {
            return UIColor.label
        }
        
        var reviewSubTitleLabelColor: UIColor {
            return UIColor.secondaryLabel
        }
        
        var reviewDetailsLabelColor: UIColor {
            return UIColor.tertiaryLabel
        }
        
        var reviewBackgroundColor: UIColor {
            return UIColor.tertiarySystemGroupedBackground
        }
    }
}
