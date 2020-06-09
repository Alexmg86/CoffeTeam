//
//  Order.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 09.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import Foundation

struct Order: Codable {
    let group: String
    let price: String
    let good: String
    let hash: String
    
    init(group: Int, price: String, good: Int, hash: String) {
        self.group = String(group)
        self.price = price
        self.good = String(good)
        self.hash = hash
    }
}
