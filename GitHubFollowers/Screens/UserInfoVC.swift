//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 26/06/22.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlign: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: FollowerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUser()
    }
    
    func getUser(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went worng",
                    message: error.rawValue,
                    bnuttonTitle: "Ok"
                )
            }
        }
    }
    
    func configureUIElements(with user: User) {
        let repoItemVC          = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self
        
        let followerItemVC      = GFFollowerVC(user: user)
        followerItemVC.delegate = self
        
        self.add(
            childVC: GFUserInfoHeaderVC(user: user),
            to: self.headerView
        )
        self.add(
            childVC: repoItemVC,
            to: self.itemViewOne
        )
        self.add(
            childVC: followerItemVC,
            to: self.itemViewTwo
        )
        self.dateLabel.text = "Github since \(user.createdAt.converToDisplayFormat())"
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVc)
        )
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func layoutUI(){
        let padding: CGFloat = 20
        let itemHeight:CGFloat = 140
        
        //isso é para a parte repetitiva
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemview in itemViews {
            view.addSubview(itemview)
            itemview.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childVC: UIViewController, to container: UIView) {
        addChild(childVC)
        container.addSubview(childVC.view)
        childVC.view.frame = container.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVc() {
        dismiss(animated: true)
    }

}

extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(
                title: "Invalid URL",
                message: "The URL of this sucker is invalid",
                bnuttonTitle: "OK"
            )
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        delegate.didRequestFollowers(for: user.login)
    }

}
