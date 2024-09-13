//
//  SearchViewController.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import UIKit

class SearchViewController: GFDataLoadingVC {
    
    // MARK: - Properties
    
    var isUsernameEntered: Bool { !userNameTextField.text!.isEmpty }
    var logoImageViewTopContraint: NSLayoutConstraint!
    
    // MARK: - Subviews
    
    let logoImageView      = UIImageView()
    let userNameTextField  = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //precisa ser nesse método pra sempre ocultar, e não só na primeira vez
        //navigationController?.isNavigationBarHidden = true 
        //ocultar a barrinha de cima da navigationController
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Configuration
    
    private func configure() {
        view.addSubviews(logoImageView, userNameTextField, callToActionButton)
        setupViews()
        hideKeyboard()
    }
    
    private func setupViews() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        userNameTextField.delegate = self
        
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            //geralmente são 4 constrains, width, height, eixo X e eixo Y. se passar disso, menos, provavelmente está errado
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), //sempre negativo
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
        
    // MARK: - Gestures
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Actions
    
    @objc func pushFollowerListVC() {
        //passando dados de uma tela para a proxima
        
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(
                title: "Empty username",
                message: "please enter a username. We need to know who to look for 🥹",
                bnuttonTitle: "Ok"
            )
            return
        }
        
        let followerListVc = FollowerListVC(username: userNameTextField.text!)
        navigationController?.pushViewController(followerListVc, animated: true)
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
