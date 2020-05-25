//
//  User.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 09.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class User {
    let userDefaults = UserDefaults.standard
    
    let email: String = ""
    let hash: String = ""
    let name: String = ""
    
    func isUserExist() -> Bool {
        let hash = userDefaults.string(forKey: "coffeapp_user_hash")
        return (hash == nil) ? false : true
    }
    
    func getHash() -> String {
        let hash = userDefaults.string(forKey: "coffeapp_user_hash")
        return ((hash == nil) ? "" : hash)!
    }
    
    func userExit() {
        userDefaults.set(nil, forKey: "coffeapp_user_hash")
        userDefaults.set(nil, forKey: "coffeapp_user_name")
        userDefaults.set(nil, forKey: "coffeapp_user_email")
    }
}
