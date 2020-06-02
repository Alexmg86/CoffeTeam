//
//  RegistrationViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 19.03.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegistrationViewController: KeyboadController {

    @IBOutlet weak var emailTextField: CustomInputField!
    @IBOutlet weak var passwordTextField: CustomInputField!
    @IBOutlet weak var passwordConfirmTextField: CustomInputField!
    @IBOutlet weak var nameTextField: CustomInputField!
    @IBOutlet weak var createAccount: CustomButton!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var password_confirmation: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        emailTextField.delegate = self
        nameTextField.delegate = self
        email.text = "Email"
        password.text = "Пароль"
        password_confirmation.text = "Подтвердите пароль"
        name.text = "Имя (то как вас будут видеть)"
    }

    @IBAction func registerTapped(_ sender: UIButton) {
        weak var pvc = self.presentingViewController

        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let passwordConfirm = passwordConfirmTextField.text,
            let nickname = nameTextField.text,
            email != "", password != "", passwordConfirm != "", nickname != "" else { return }
        guard password == passwordConfirm else {
            self.callError(key: "password", errors: ["Пароли не совпадают"])
            return
        }
        let registration = Registration(email: email, password: password, password_confirmation: passwordConfirm, name: nickname)

        AF.request("https://ineedapp.ru/register",
                   method: .post,
                   parameters: registration,
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
                    self?.dismiss(animated: true, completion: {
                        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupRegistration") as! PopUpRegistrationViewController
                        pvc?.addChild(popOverVC)
                        popOverVC.view.frame = (pvc?.view.frame)!
                        pvc?.view.addSubview(popOverVC.view)
                        popOverVC.didMove(toParent: pvc)
                    })
                default:
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func closeRegisterForm(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
