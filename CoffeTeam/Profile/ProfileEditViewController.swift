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

class ProfileEditViewController: KeyboadController {
    
    @IBOutlet weak var nameTextField: CustomInputField!
    @IBOutlet weak var updateAccount: CustomButton!
    @IBOutlet weak var exitAccount: UIButton!
    @IBOutlet weak var name: UILabel!
    
    let user = User()
    
    override var disableScroll : Bool {
        get {
            return true
        }
        set {
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        name.text = "Имя (то как вас будут видеть)"
        nameTextField.text = user.getName()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func updateUser(_ sender: Any) {
        guard let nickname = nameTextField.text, nickname != "" else {
            self.callError(key: "name", errors: ["Поле на заполнено"])
            return
        }
        let id = user.getId()
        let hash = user.getHash()
        guard id != "", hash != "" else { return }
        let url = "https://ineedapp.ru/user/\(String(id))"
        let headers: HTTPHeaders = [
            "hash": user.getHash()
        ]
        AF.request(url,
                   method: .put,
                   parameters: ["name": nickname],
                   headers: headers).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value as Any)
                let status = response.response!.statusCode
                switch status {
                case 200:
                    self?.user.userUpdate(json: json)
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
        let headers: HTTPHeaders = [
            "hash": user.getHash()
        ]
        AF.request("https://ineedapp.ru/logout",
                   method: .post,
                   parameters: parameters,
                   headers: headers).response { [weak self] response in
            switch response.result {
            case .success( _):
                self?.user.userExit()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadItems"), object: nil)
                self?.dismiss(animated: true, completion: nil)
            case .failure(_):
                print("error")
            }
        }
    }
}
