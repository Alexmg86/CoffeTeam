//
//  RegistrationViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 19.03.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: CustomInputField!
    @IBOutlet weak var passwordTextField: CustomInputField!
    @IBOutlet weak var nameTextField: CustomInputField!
    @IBOutlet weak var createAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tap)
        self.addObserves()
        createAccount.layer.cornerRadius = 10
    }
    
    @objc func didTapView() {
        view.endEditing(true)
    }
    
    func addObserves() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo  else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + kbFrameSize.height)
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height - self.view.safeAreaInsets.bottom, right: 0)
        (self.view as! UIScrollView).contentOffset = CGPoint(x: 0, y: (self.view.bounds.height / 2) - 200)
    }
    
    @objc func keyboardWillHide() {
        (self.view as! UIScrollView).contentOffset = CGPoint.zero
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    }
    
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
    }
}

