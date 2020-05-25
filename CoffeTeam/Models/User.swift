//
//  User.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 09.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

struct User: Encodable {
    let email: String
    let hash: String
    let name: String
}
