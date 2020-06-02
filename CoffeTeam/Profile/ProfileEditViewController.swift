//
//  ProfileEditViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 26.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileEditViewController: KeyboardEasyViewController {
    
    @IBOutlet weak var nameTextField: CustomInputField!
    @IBOutlet weak var updateAccount: CustomButton!
    @IBOutlet weak var exitAccount: UIButton!
    @IBOutlet weak var name: UILabel!
    
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        name.text = "Имя (то как вас будут видеть)"
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func updateUser(_ sender: Any) {
        guard let nickname = nameTextField.text, nickname != "" else {
            self.callError(key: "name", errors: ["Поле на заполнено"])
            return
        }
        let hash = user.getHash()
        guard hash != "" else { return }
        
        AF.request("https://ineedapp.ru/updateUser",
                   method: .post,
                   parameters: ["name": nickname, "hash": hash],
                   encoder: JSONParameterEncoder.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value as Any)
                let status = response.response!.statusCode
                switch status {
                case 200:
                    if (json.count == 3) {
                        let userDefaults = UserDefaults.standard
                        for (key, value) in json {
                            userDefaults.set(value.stringValue, forKey: "coffeapp_user_"+key)
                        }
                    }
                    self?.dismiss(animated: true, completion: nil)
                default:
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func exitUser(_ sender: Any) {
        let parameters: Parameters = [:]
        AF.request("https://ineedapp.ru/logout",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default).response { [weak self] response in
            switch response.result {
            case .success( _):
                self?.user.userExit()
                self?.dismiss(animated: true, completion: nil)
            case .failure(_):
                print("error")
            }
        }
    }
}
