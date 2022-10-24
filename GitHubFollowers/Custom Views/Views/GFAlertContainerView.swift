//
//  GFAlertContainerView.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 23/10/22.
//

import UIKit

class GFAlertContainerView: UIView {

    //-----------------------------------------------------------------------
    // MARK: - Inicialization
    //-----------------------------------------------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Configuration
    //-----------------------------------------------------------------------
    
    private func configure() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
