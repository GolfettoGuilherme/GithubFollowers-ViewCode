//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 26/06/22.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    //-----------------------------------------------------------------------
    // MARK: - Static properties
    //-----------------------------------------------------------------------
    
    static let reuseId = "FollowerCell"
    
    //-----------------------------------------------------------------------
    // MARK: - Subviews
    //-----------------------------------------------------------------------
    
    let avatarimageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlign: .center, fontSize: 16)
    
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
    // MARK: - Configurations
    //-----------------------------------------------------------------------
    
    private func configure() {
        addSubviews(avatarimageView, usernameLabel)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarimageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarimageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding), //isso ja define o tamanho de width
            avatarimageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarimageView.heightAnchor.constraint(equalTo: avatarimageView.widthAnchor), //para deixar quadrado
            
            usernameLabel.topAnchor.constraint(equalTo: avatarimageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async { self.avatarimageView.image = image }
        }
    }

}
