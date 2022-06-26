//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlign: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlign
        configure()
    }
    
    private func configure() {
        textColor                 = .secondaryLabel
        font                      = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.75
        lineBreakMode             = .byWordWrapping //como quebrar a linha
        translatesAutoresizingMaskIntoConstraints = false //sempre colocar isso
    }

}
