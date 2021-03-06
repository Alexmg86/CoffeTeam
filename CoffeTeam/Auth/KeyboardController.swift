//
//  KeyboardController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 01.04.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//
import UIKit
import SwiftyJSON

class KeyboadController: UIViewController, UITextFieldDelegate {
    
    var disableScroll = false
    var topPoint = 226

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        if !disableScroll {
            self.addObserves()
        }
    }

    @objc func didTapView() {
        view.endEditing(true)
    }

    func addObserves() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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

    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo  else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height - self.view.safeAreaInsets.bottom, right: 0)
        (self.view as! UIScrollView).contentOffset = CGPoint(x: 0, y: topPoint)
    }
    
    @objc func keyboardWillHide() {
        (self.view as! UIScrollView).contentOffset = CGPoint.zero
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
}
