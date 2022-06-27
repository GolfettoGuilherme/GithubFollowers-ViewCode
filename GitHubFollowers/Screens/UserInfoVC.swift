//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 26/06/22.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    
    var itemViews: [UIView] = []
    
    var username: String!

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
                
                DispatchQueue.main.async {
                    self.add(
                        childVC: GFUserInfoHeaderVC(user: user),
                        to: self.headerView
                    )
                    self.add(
                        childVC: GFRepoItemVC(user: user),
                        to: self.itemViewOne
                    )
                    self.add(
                        childVC: GFFollowerVC(user: user),
                        to: self.itemViewTwo
                    )
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Something went worng",
                    message: error.rawValue,
                    bnuttonTitle: "Ok"
                )
            }
        }
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
        itemViews = [headerView, itemViewOne, itemViewTwo]
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
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
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
