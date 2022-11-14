//
//  GFTitleLabel.swift
//  GitHubFollowers
//
//  Created by Guilherme Golfetto on 25/06/22.
//

import UIKit

class GFTitleLabel: UILabel {
    
    //-----------------------------------------------------------------------
    // MARK: - Inicializtion
    //-----------------------------------------------------------------------
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlign: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero) //chama o init de cima
        self.textAlignment = textAlign
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Configuration
    //-----------------------------------------------------------------------
    
    private func configure() {
        textColor                 = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        lineBreakMode             = .byTruncatingTail //como quebrar a linha
        translatesAutoresizingMaskIntoConstraints = false //sempre colocar isso
    }
    
}
