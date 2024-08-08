//
// Copyright © 2023 Alpha Apps LLC. All rights reserved.
//

import UIKit
import PaywallsKit

enum Variant: String {
    
    case snowball
    case clover
    case moses
}

extension Variant {
    
    var name: String {
        return rawValue
    }
    
    var viewController: UIViewController & PaywallViewControllerProtocol {
        let builder = PaywallBuilder()
        switch self {
        case .snowball:
            return builder.makeShowballPaywall()
        case .clover:
            return builder.makeCloverPaywall()
        case .moses:
            return builder.makeMosesPaywall()
        }
    }
}

class HomeViewController: UITableViewController {
    
    private lazy var variants: [Variant] = {
        [.snowball, .clover, .moses]
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
        
        DispatchQueue.main.async {
            self.openPaywall(Variant.moses)
        }
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
        
//        let nvc = UINavigationController(rootViewController: PresentPaywallViewController(with: variant))
        let nvc = PresentPaywallViewController(with: variant)
        nvc.modalPresentationStyle = .fullScreen
        
        navigationController.present(nvc, animated: true)
    }
}
