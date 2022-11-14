//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 12/11/22.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCell() {
        tableFooterView = UIView(frame: .zero)
    }
}
