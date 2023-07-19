//
// Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    public func configureEmptyHeaderView() {
        configureEmptyHeaderView(withHeight: .leastNormalMagnitude)
    }
    
    public func configureEmptyHeaderView(withHeight height: CGFloat) {
        tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    
    public func configureEmptyHeaderViewDefault() {
        configureEmptyHeaderView(withHeight: 12)
    }
    
    public func configureEmptyFooterView() {
        configureEmptyFooterView(withHeight: .leastNormalMagnitude)
    }
    
    public func configureEmptyFooterView(withHeight height: CGFloat) {
        tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: height))
    }
    
    public func configureEmptyFooterViewDefault() {
        configureEmptyFooterView(withHeight: 12)
    }
}
