//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView      = UIImageView()
    let userNameTextField  = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool { !userNameTextField.text!.isEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground //usar isso faz ele ajustar sozinho pro darkmode
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //precisa ser nesse método pra sempre ocultar, e não só na primeira vez
        //navigationController?.isNavigationBarHidden = true //ocultar a barrinha de cima da navigationController
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        //isso serve para ocultar o teclado sempre que o usuario clicar fora da tela. muito util
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
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
        
        let followerListVc       = FollowerListVC()
        followerListVc.username  = userNameTextField.text
        followerListVc.title     = userNameTextField.text
        navigationController?.pushViewController(followerListVc, animated: true)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            //geralmente são 4 constrains, width, height, eixo X e eixo Y. se passar disso, menos, provavelmente está errado
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), //sempre negativo
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50), //negativo sempre
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), //negativo sempre
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
