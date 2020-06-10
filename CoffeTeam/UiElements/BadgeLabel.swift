//
//  BadgeLabel.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 10.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class BadgeLabel: UILabel {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        textColor = .white
        textAlignment = .center
        self.layer.cornerRadius = 14
        self.clipsToBounds = true
        self.backgroundColor = #colorLiteral(red: 0.8509803922, green: 0.6196078431, blue: 0.5882352941, alpha: 1)
    }
}
