//
//  CustomLabel.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 13.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        textColor = #colorLiteral(red: 0.2196078431, green: 0.2431372549, blue: 0.2588235294, alpha: 0.5)
        font = UIFont.systemFont(ofSize: 11.0, weight: .bold)
    }
    
}
