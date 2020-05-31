//
//  Goods.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 29.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import Foundation

struct Goods: Encodable {
    let icon_id: Int
    let group_id: Int
    let name: String
    let price: String
}
