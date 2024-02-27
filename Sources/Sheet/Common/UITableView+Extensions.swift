//
// Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

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
    
    public static let defaultSeparatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    
    public static let hiddenSeparatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
}
