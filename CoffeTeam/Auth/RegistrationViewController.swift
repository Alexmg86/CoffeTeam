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
    
    var ref: DatabaseReference!

    @IBOutlet weak var emailTextField: CustomInputField!
    @IBOutlet weak var passwordTextField: CustomInputField!
    @IBOutlet weak var nameTextField: CustomInputField!
    @IBOutlet weak var createAccount: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        weak var pvc = self.presentingViewController
        guard let email = emailTextField.text, let password = passwordTextField.text, let nickname = nameTextField.text,
            email != "", password != "", nickname != "" else { return }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard error == nil, authResult?.user != nil else {
                print(error!.localizedDescription)
                return
            }
            self?.ref.child("users").child((authResult?.user.uid)!).setValue(["nickname": nickname, "email": email])
            self?.dismiss(animated: true, completion: {
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupRegistration") as! PopUpRegistrationViewController
                pvc?.addChild(popOverVC)
                popOverVC.view.frame = (pvc?.view.frame)!
                pvc?.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParent: pvc)
            })
        }
    }
    
    @IBAction func closeRegisterForm(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
