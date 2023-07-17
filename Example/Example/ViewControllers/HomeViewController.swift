//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import UIKit
import AlphaPaywallVariants

enum Variant: String {
    
    case simply
    case longiflorum
}

extension Variant {
    
    var name: String {
        switch self {
        case .simply:
            return "Simply"
        case .longiflorum:
            return "Longiflorum"
        }
    }
    
    var viewController: UIViewController {
        let builder = PaywallBuilder()
        switch self {
        case .simply:
            return builder.makeSimplyPaywall()
        case .longiflorum:
            return builder.makeLongiflorumPaywall()
        }
    }
}

class HomeViewController: UITableViewController {
    
    private lazy var variants: [Variant] = {
        [.simply, .longiflorum]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUI()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
    }
    
    private func setupUI() {
        navigationItem.title = "Paywall Variants"
        navigationItem.backButtonTitle = "Back"
    }
}

extension HomeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        cell.textLabel?.text = variants[indexPath.item].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        openPaywall(variants[indexPath.item])
    }
}

extension HomeViewController {
    
    private func openPaywall(_ variant: Variant) {
        guard let navigationController = navigationController else {
            return
        }
        
        let vc = variant.viewController
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalPresentationStyle = .fullScreen
        
        navigationController.present(nvc, animated: true)
    }
}
