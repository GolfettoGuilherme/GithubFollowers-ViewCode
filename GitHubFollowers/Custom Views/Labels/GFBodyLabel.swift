//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import UIKit

class GFBodyLabel: UILabel {
    
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
    
    convenience init(textAlign: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlign
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Configuration
    //-----------------------------------------------------------------------
    
    private func configure() {
        textColor                 = .secondaryLabel
        font                      = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.75
        lineBreakMode             = .byWordWrapping //como quebrar a linha
        translatesAutoresizingMaskIntoConstraints = false //sempre colocar isso
    }

}
