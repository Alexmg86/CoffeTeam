//
//  LoginViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 01.04.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class LoginViewController: KeyboadController {

    @IBOutlet weak var emailTextField: CustomInputField!
    @IBOutlet weak var passwordTextField: CustomInputField!
    @IBOutlet weak var loginAccount: CustomButton!
    @IBOutlet weak var createAccount: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapper(_ sender: UIButton) {
    }
}
