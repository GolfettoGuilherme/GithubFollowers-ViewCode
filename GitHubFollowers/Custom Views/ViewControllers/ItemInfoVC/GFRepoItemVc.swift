//
//  GFRepoItemVc.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 26/06/22.
//

import UIKit

//herança
class GFRepoItemVC: GFItemInfoVC {
    
    //-----------------------------------------------------------------------
    // MARK: - View lifecycle
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Configuration
    //-----------------------------------------------------------------------
    
    private func configure(){
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    //-----------------------------------------------------------------------
    // MARK: - objc methods
    //-----------------------------------------------------------------------
    
    override func actionButtonTapped() {
        delegate.didTapGithubProfile(for: user)
    }
}
