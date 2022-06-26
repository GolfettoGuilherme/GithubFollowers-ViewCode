//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import UIKit

extension UIViewController {
    
    func presentGFAlertOnMainThread(title:String, message:String, bnuttonTitle:String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: bnuttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
