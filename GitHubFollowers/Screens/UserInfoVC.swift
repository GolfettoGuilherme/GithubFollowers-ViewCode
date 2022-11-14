//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 26/06/22.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    //-----------------------------------------------------------------------
    // MARK: - Subviews
    //-----------------------------------------------------------------------
    
    let scrollview  = UIScrollView()
    let contentView = UIView()
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlign: .center)
    var itemViews: [UIView] = []
    
    //-----------------------------------------------------------------------
    // MARK: - Properties
    //-----------------------------------------------------------------------
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    //-----------------------------------------------------------------------
    // MARK: - View lifecycle
    //-----------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVc)
        )
        navigationItem.rightBarButtonItem = doneButton
        
        configureScrollView()
        configure()
        getUser()
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Configuration
    //-----------------------------------------------------------------------
    
    private func configureScrollView(){
        view.addSubview(scrollview)
        scrollview.addSubview(contentView)
        scrollview.pintToEdges(of: view)
        contentView.pintToEdges(of: scrollview)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollview.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func configure(){
        let padding: CGFloat = 20
        let itemHeight:CGFloat = 140
        
        //isso é para a parte repetitiva
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemview in itemViews {
            contentView.addSubview(itemview)
            itemview.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureUIElements(with user: User) {
        self.add(
            childVC: GFUserInfoHeaderVC(user: user),
            to: self.headerView
        )
        self.add(
            childVC: GFRepoItemVC(user: user, delegate: self),
            to: self.itemViewOne
        )
        self.add(
            childVC: GFFollowerVC(user: user, delegate: self),
            to: self.itemViewTwo
        )
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private methods
    //-----------------------------------------------------------------------
    
    private func getUser(){
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

//-----------------------------------------------------------------------
// MARK: - Delegates
//-----------------------------------------------------------------------

extension UserInfoVC: GFRepoInfoVCDelegate {
    
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
}

extension UserInfoVC: GFFollwerCDelegate {
    
    func didTapGetFollowers(for user: User) {
        delegate.didRequestFollowers(for: user.login)
    }
}

