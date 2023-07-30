//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

@MainActor public protocol LongiflorumPaywallDataSource: AnyObject {
    
    func getTitle() -> NSAttributedString
    
    func getTitle() -> String
    
    func getProductSection() -> LongiflorumPaywallViewController.ProductsItemViewModel
    
    func getBenefitSection() -> LongiflorumPaywallViewController.BenefitsItemViewModel
    
    func getAwardSection() -> LongiflorumPaywallViewController.AwardItemViewModel?
    
    func getFeatureSection() -> LongiflorumPaywallViewController.FeaturesItemViewModel?
    
    func getReviewSection() -> LongiflorumPaywallViewController.ReviewsItemViewModel?
    
    func getHelpSection() -> LongiflorumPaywallViewController.HelpSectionItemViewModel?
    
    func getTodoSection(forProduct id: String) -> LongiflorumPaywallViewController.TodosItemViewModel?
    
    func getDisclamerSection(forProduct id: String) -> LongiflorumPaywallViewController.DisclamerItemViewModel?
    
    func getContinueButtonText(forProduct id: String) -> String?
}
