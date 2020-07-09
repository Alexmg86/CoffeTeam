//
//  LoginViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 01.04.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: KeyboadController {

    @IBOutlet weak var emailTextField: CustomInputField!
    @IBOutlet weak var passwordTextField: CustomInputField!
    @IBOutlet weak var loginAccount: CustomButton!
    @IBOutlet weak var createAccount: CustomButton!
    @IBOutlet weak var closeButtom: UIButton!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var password: UILabel!
    let user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        email.text = "Email"
        password.text = "Пароль"
    }
    
    func loginUser(email: String, password: String) {
        let login = Login(email: email, password: password)
        AF.request("https://ineedapp.ru/login",
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value as Any)
                let status = response.response!.statusCode
                switch status {
                case 422:
                    for (key, error) in json {
                        self?.callError(key: key, errors: error)
                    }
                case 200:
                    self?.user.userUpdate(json: json)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadItems"), object: nil)
                    self?.dismiss(animated: true, completion: nil)
                default:
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func loginTapper(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "" else {
            self.callError(key: "email", errors: ["Не указан логин"])
            return
        }
        guard let password = passwordTextField.text, password != "" else {
            self.callError(key: "password", errors: ["Не указан пароль"])
            return
        }
        loginUser(email: email, password: password)
    }
    
    @IBAction func closeLoginForm(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
