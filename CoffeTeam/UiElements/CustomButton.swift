//
//  CustomButton.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 01.04.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
