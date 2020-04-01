//
//  RegistrationViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 19.03.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: KeyboadController {

    
    @IBOutlet weak var emailTextField: CustomInputField!
    @IBOutlet weak var passwordTextField: CustomInputField!
    @IBOutlet weak var nameTextField: CustomInputField!
    @IBOutlet weak var createAccount: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let nickname = nameTextField.text,
            email != "", password != "", nickname != "" else { return }
        print("Все есть")
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                print(error!)
                return }
            print(user)
            print("\(user.email!) created")
        }
    }
}
