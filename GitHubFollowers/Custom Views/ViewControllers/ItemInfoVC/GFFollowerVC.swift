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
}
