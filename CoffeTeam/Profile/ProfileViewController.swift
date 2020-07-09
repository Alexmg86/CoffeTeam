//
//  ProfileViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 06.04.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileViewController: UIViewController {

    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var createAccount: CustomButton!
    @IBOutlet weak var enterAccountBtn: UIButton!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var editAccount: UIBarButtonItem!
    
    let user = User()
    var rightBarButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rightBarButton = editAccount
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isUserExist()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func isUserExist() {
        if user.isUserExist() {
            infoStackView.isHidden = false
            loginStackView.isHidden = true
            userNameLabel.text = user.getName()
            self.navigationItem.rightBarButtonItem = rightBarButton
        } else {
            infoStackView.isHidden = true
            loginStackView.isHidden = false
            self.navigationItem.rightBarButtonItem = nil
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
    
    @IBAction func editAccount(_ sender: Any) {
        self.performSegue(withIdentifier: "profileEdit",sender: self)
    }
}
