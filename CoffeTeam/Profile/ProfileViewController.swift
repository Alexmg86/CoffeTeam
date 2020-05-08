//
//  ProfileViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 06.04.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    let user = Auth.auth().currentUser
    
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var createAccount: CustomButton!
    @IBOutlet weak var enterAccountBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginStackView.isHidden = self.isUserExist();
    }
    
    func isUserExist() -> Bool {
        if user != nil {
            return true
        } else {
            return false
        }
    }
    @IBAction func createAccount(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationOne") as! RegistrationViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
    @IBAction func enterAccount(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginOne") as! LoginViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func userInfo(_ sender: Any) {
        
        if user != nil {
            print("user exist")
        } else {
            print("user not exist")
        }
    }
    @IBAction func signIn(_ sender: Any) {
        print("signIn")
        Auth.auth().signIn(withEmail: "2@mail.ru", password: "1234567") { [weak self] authResult, error in
            guard self != nil else { return }
            print(error?.localizedDescription as Any)
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "RegistrationOne") as! RegistrationViewController
//        self.present(nextViewController, animated:true, completion:nil)
        
//        let user = Auth.auth().currentUser
//        if user != nil {
//            print(user?.uid)
//        } else {
//            print("нет")
//        }
//        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupRegistration") as! PopUpRegistrationViewController
//        self.addChild(popOverVC)
//        popOverVC.view.frame = self.view.frame
//        self.view.addSubview(popOverVC.view)
//        popOverVC.didMove(toParent: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
