//
//  KeyboardEasyViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 26.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import SwiftyJSON

class KeyboardEasyViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Вывод ошибок в лейбл и инпут после api запросов
    func callError(key: String, errors: JSON) {
        guard key != "", let editingField = self.value(forKey: key + "TextField") as? CustomInputField, let label = self.value(forKey: key) as? CustomLabel else {return}
        var str = ""
        for (_, error) in errors {
            if let title = error.string {
                str += title + " "
            }
        }
        editingField.textFieldError(name: key)
        label.errorText = str
        label.error = true
    }

    // Отмена ошибок в лейбле
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let editingField = textField as? CustomInputField, editingField.nameLabel != "" else {return}
        if let label = self.value(forKey: editingField.nameLabel) as? CustomLabel {
            label.error = false
        }
    }
}
