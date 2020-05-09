//
//  LoginViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 01.04.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: KeyboadController {
    
    let user = Auth.auth().currentUser

    @IBOutlet weak var emailTextField: CustomInputField!
    @IBOutlet weak var passwordTextField: CustomInputField!
    @IBOutlet weak var loginAccount: CustomButton!
    @IBOutlet weak var createAccount: CustomButton!
    @IBOutlet weak var closeButtom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapper(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if authResult?.user != nil {
                self?.dismiss(animated: true, completion: nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }
    
    @IBAction func closeLoginForm(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
