//
//  GFDataLoadingVC.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 23/10/22.
//

import UIKit

class GFDataLoadingVC: UIViewController {
    
    //-----------------------------------------------------------------------
    // MARK: - Subviews
    //-----------------------------------------------------------------------
    
    var containerView: UIView!
    
    //-----------------------------------------------------------------------
    // MARK: - Inicialization
    //-----------------------------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds) //vai tampar a tela toda, ai nao precisa de constraints
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicador = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicador)
        
        activityIndicador.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicador.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicador.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicador.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

}
