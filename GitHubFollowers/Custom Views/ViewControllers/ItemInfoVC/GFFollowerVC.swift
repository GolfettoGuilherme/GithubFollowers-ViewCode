//
//  GFFollowerVC.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 26/06/22.
//

import Foundation

//herança
class GFFollowerVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        //coisas especificas
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen , title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(
                title: "No Followers :(",
                message: "This sucker does not have followers. shame 🤡",
                bnuttonTitle: "OK"
            )
            return
        }
        
        delegate.didTapGetFollowers(for: user)
        dismiss(animated: true)
    }
}
