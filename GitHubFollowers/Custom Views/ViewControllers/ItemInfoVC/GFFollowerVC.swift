//
//  GFFollowerVC.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 26/06/22.
//

import Foundation

protocol GFFollwerCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerVC: GFItemInfoVC {
    
    //-----------------------------------------------------------------------
    // MARK: - Delegate
    //-----------------------------------------------------------------------
    
    weak var delegate: GFFollwerCDelegate!
    
    //-----------------------------------------------------------------------
    // MARK: - View lifecycle
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Inicialization
    //-----------------------------------------------------------------------
    
    init(user: User, delegate: GFFollwerCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Configuration
    //-----------------------------------------------------------------------
    
    private func configure(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen , title: "Get Followers")
    }
    
    //-----------------------------------------------------------------------
    // MARK: - objc methods
    //-----------------------------------------------------------------------
    
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
