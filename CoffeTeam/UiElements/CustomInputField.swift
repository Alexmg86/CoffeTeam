//
//  CustomInputField.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 31.03.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class CustomInputField: UITextField {
    
    var error: Bool = false
    var count: Int = 0
    var nameLabel: String = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        addSublayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textFieldSetup()
    }
    
    func addSublayer() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: frame.height - 1, width: bounds.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        bottomLine.name = "custom_underline"
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }

    func textFieldError(name: String) {
        error = true
        nameLabel = name
        textFieldSetup()
    }

    private func textFieldSetup() {
        var color = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        if (self.text!.count > 0) {
            color = UIColor(red: 88/255, green: 150/255, blue: 139/255, alpha: 1)
        }
        if (count != self.text!.count) {
            error = false
        }
        if (error) {
            color = #colorLiteral(red: 0.9568627451, green: 0.262745098, blue: 0.2117647059, alpha: 1)
        }
        if let sublayers = self.layer.sublayers {
            if let lay = sublayers.filter({ $0.name == "custom_underline" }).first {
                lay.backgroundColor = color.cgColor
            }
        }
        count = self.text!.count
    }
}
