//
//  Registration.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 22.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

struct Registration: Encodable {
    let email: String
    let password: String
    let password_confirmation: String
    let name: String
}
