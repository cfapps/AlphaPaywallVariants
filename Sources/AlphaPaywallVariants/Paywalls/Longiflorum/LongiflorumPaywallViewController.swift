//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import Foundation
import UIKit
import QuickTableKit

open class LongiflorumPaywallViewController: QuickTableViewController {
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    open override func setupTableView() {
        super.setupTableView()
        
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        tableView.register(headerFooterType: TitleTableViewHeader.self)
        
        tableView.register(cellType: AwardTableViewCellModel.type)
        tableView.register(cellType: ObjectComparisonTableViewCellModel.type)
        tableView.register(cellType: ReviewTableViewCellModel.type)
        tableView.register(cellType: QuestionTableViewCellModel.type)
        
        tableView.estimatedRowHeight = 263
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    open override func setupTableData() {
        collection.add(section: QuickTableViewSection(
            items: [
                AwardTableViewCellModel(
                    title: "Trusted by 10,000 Businesses Worldwide. Boost Your Business Growth with GetInvoice",
                    subTitle: "Featured in 12 countries",
                    details: "Apps for\nSmall Business",
                    contentColor: UIColor(red: 0, green: 0.48, blue: 1, alpha: 0.08),
                    textColor: UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
                )
            ]
        ))
        
        collection.add(section: QuickTableViewSection(
            header: TitleTableViewHeaderModel(titleText: "Great Features You will Love", textColor: .black),
            items: [
                ObjectComparisonTableViewCellModel(
                    items: [
                        "Unlimited Invoices",
                        "Follow-up Reminders",
                        "Custom Templates",
                        "Custom Reports",
                        "Add-Free Experience",
                        "Priority Support"
                    ],
                    contentColor: UIColor(red: 0, green: 0.48, blue: 1, alpha: 0.08),
                    textColor: UIColor(red: 0, green: 0.48, blue: 1, alpha: 1)
                )
            ]
        ))
        
        collection.add(section: QuickTableViewSection(
            header: TitleTableViewHeaderModel(titleText: "Trusted by Thousands", textColor: .black),
            items: [
                ReviewTableViewCellModel(
                    title: "I am happy",
                    description: "As a small business owner, I appreciate how straightforward it was to set up and generate invoices. Thank you for simplifying the process for us",
                    name: "NYPlumber07",
                    bottomInset: 8
                ),
                ReviewTableViewCellModel(
                    title: "I am happy",
                    description: "As a small business owner, I appreciate how straightforward it was to set up and generate invoices. Thank you for simplifying the process for us",
                    name: "NYPlumber07",
                    topInset: 8
                )
            ]
        ))
        
        collection.add(section: QuickTableViewSection(
            header: TitleTableViewHeaderModel(titleText: "Most Asked Questions", textColor: .black),
            items: [
                QuestionTableViewCellModel(
                    titleText: "Can I share my subscription with a family member?",
                    descriptionText: "Yes, absolutely! Your subscription will be automatically shared with everyone you’ve shared your Apple ID account."
                ),
                QuestionTableViewCellModel(
                    titleText: "Do subscriptions renew automatically?",
                    descriptionText: "All GetInvoice Subscriptions are automatically renewed to ensure constant access for you. If you choose to cancel the automatic renewal, your subscription will expire."
                ),
                QuestionTableViewCellModel(
                    titleText: "How can I cancel subscription?",
                    descriptionText: "Open Settings of your iPhone or iPad > Click your Name > Subscriptions > Select GetInvoice > Tap Cancel Subscription."
                ),
                QuestionTableViewCellModel(
                    titleText: "Can i get my money back if i change my mind?",
                    descriptionText: "If you’re not satisfied with your subscription, it’s possible to apply for a refund from AppStore. Go to https://reportaproblem.apple.com/. Log in with your Apple ID. Select \"Request a refund\". Select a reason for refund, then select the subscription."
                )
            ]
        ))
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        var apperance = UINavigationBarAppearance()
        apperance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = apperance
        
        apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        navigationController?.navigationBar.compactAppearance = apperance
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
    }
    
    private func setupUI() {
        view.addSubview(bottomView)
        bottomView.backgroundColor = .red
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(120)
        }
    }
}

extension LongiflorumPaywallViewController {
    
    open override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return collection.hasHeader(at: section) ? UITableView.automaticDimension : 0
    }
    
    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard collection.hasHeader(at: section) else {
            return nil
        }
        
        return tableViewDataSource.dequeue(tableView, viewForHeaderInSection: section)
    }
    
    open override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return collection.hasFooter(at: section) ? UITableView.automaticDimension : 0
    }
    
    open override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard collection.hasFooter(at: section) else {
            return nil
        }
        
        return tableViewDataSource.dequeue(tableView, viewForFooterInSection: section)
    }
}
