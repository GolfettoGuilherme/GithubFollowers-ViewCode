//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(
            for: username,
            page: 1) { result in
            
            switch result {
            
            case .success(let followers):
                print("Followers.count = \(followers.count)")
                print(followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Bad stuff message",
                    message: error.rawValue,
                    bnuttonTitle: "ok"
                )
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
