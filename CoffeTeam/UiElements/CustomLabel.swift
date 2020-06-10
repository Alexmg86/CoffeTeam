//
//  CustomLabel.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 13.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    var labelText: String = ""
    var errorText: String = ""

    var error: Bool = false {
        didSet {
            if (error) {
                textColor = #colorLiteral(red: 0.9568627451, green: 0.262745098, blue: 0.2117647059, alpha: 1)
                text = errorText
            } else {
                textColor = #colorLiteral(red: 0.2196078431, green: 0.2431372549, blue: 0.2588235294, alpha: 0.5)
                text = labelText
            }
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        textColor = #colorLiteral(red: 0.8509803922, green: 0.6196078431, blue: 0.5882352941, alpha: 1)
        font = UIFont.systemFont(ofSize: 11.0, weight: .bold)
        labelText = text!
    }
}
