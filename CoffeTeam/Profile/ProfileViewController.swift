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
    
    /** @var handle
        @brief The handler for the auth state listener, to allow cancelling later.
    */
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var createAccount: CustomButton!
    @IBOutlet weak var enterAccountBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//            self.isUserExist(user)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func isUserExist(_ user: User?) {
        print("Зашел в проверку")
        var isUserExist = false
        if user != nil {
            isUserExist = true
        }
        loginStackView.isHidden = isUserExist
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
