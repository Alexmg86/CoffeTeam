//
//  Groups.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 21.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import Foundation

struct Groups: Codable {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
