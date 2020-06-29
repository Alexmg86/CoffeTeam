//
//  User.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 09.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class User {
    let userDefaults = UserDefaults.standard
    
    let email: String = ""
    let hash: String = ""
    let name: String = ""
    let id: String = ""
    
    func isUserExist() -> Bool {
        let hash = userDefaults.string(forKey: "coffeapp_user_hash")
        return (hash == nil) ? false : true
    }
    
    func getHash() -> String {
        let hash = userDefaults.string(forKey: "coffeapp_user_hash")
        return ((hash == nil) ? "" : hash)!
    }
    
    func getName() -> String {
        let name = userDefaults.string(forKey: "coffeapp_user_name")
        return ((name == nil) ? "" : name)!
    }
    
    func getId() -> String {
        let id = userDefaults.string(forKey: "coffeapp_user_id")
        return ((id == nil) ? "" : id)!
    }
    
    func userExit() {
        userDefaults.set(nil, forKey: "coffeapp_user_hash")
        userDefaults.set(nil, forKey: "coffeapp_user_name")
        userDefaults.set(nil, forKey: "coffeapp_user_email")
        userDefaults.set(nil, forKey: "coffeapp_user_id")
    }
    
    func userUpdate(json: JSON) {
        if (json.count == 4) {
            let userDefaults = UserDefaults.standard
            for (key, value) in json {
                userDefaults.set(value.stringValue, forKey: "coffeapp_user_"+key)
            }
        }
    }
    
    func userLogin() {
        if isUserExist() {
            let url = "https://ineedapp.ru/user/loginhash"
            AF.request(url,
                       method: .post,
                       parameters: ["hash": getHash()],
                       encoder: JSONParameterEncoder.default).responseJSON { [weak self] response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value as Any)
                    let status = response.response!.statusCode
                    switch status {
                    case 200:
                        self?.userUpdate(json: json)
                    default:
                        print("error")
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
