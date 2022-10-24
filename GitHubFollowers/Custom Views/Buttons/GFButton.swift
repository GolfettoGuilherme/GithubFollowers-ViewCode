//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import UIKit

class GFButton: UIButton {
    
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
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Configuration
    //-----------------------------------------------------------------------
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------
    
    func set(backgroundColor: UIColor, title:String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
