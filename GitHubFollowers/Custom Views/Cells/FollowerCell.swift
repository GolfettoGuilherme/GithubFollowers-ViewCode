//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 26/06/22.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseId = "FollowerCell"
    
    let avatarimageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlign: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
    }
    
    
    private func configure() {
        addSubview(avatarimageView)
        addSubview(usernameLabel)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarimageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarimageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding), //isso ja define o tamanho de width
            avatarimageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarimageView.heightAnchor.constraint(equalTo: avatarimageView.widthAnchor), //para deixar quadrado
            
            usernameLabel.topAnchor.constraint(equalTo: avatarimageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
    }
    
}
