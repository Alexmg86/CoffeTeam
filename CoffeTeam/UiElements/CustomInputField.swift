//
//  CustomInputField.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 31.03.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class CustomInputField: UITextField, UITextFieldDelegate {
    
    override func awakeFromNib() {
        self.delegate = self
        textFieldSetup()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textFieldSetup()
    }

    private func textFieldSetup() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        var color = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        if (self.text!.count > 0) {
            color = UIColor(red: 88/255, green: 150/255, blue: 139/255, alpha: 1)
        }
        bottomLine.backgroundColor = color.cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
    
}
