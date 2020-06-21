//
//  InnerViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 21.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import SwiftyJSON

class InnerViewController: UIViewController {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var goodImage: UIImageView!
    var data = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
    }
    
    func updateData() {
        if data.isEmpty {
            userLabel.text = "Пока нет"
            totalLabel.text = "0"
            goodLabel.text = "Пока нет"
            goodImage.image = UIImage(named: "1")
        } else {
            let json = JSON(data as Any)
            totalLabel.text = json[0]["total"].stringValue
            if !json[0]["user"].isEmpty {
                userLabel.text = json[0]["user"]["name"].stringValue
            }
            if !json[0]["good"].isEmpty {
                goodLabel.text = json[0]["good"]["name"].stringValue
                goodImage.image = UIImage(named: json[0]["good"]["icon_id"].stringValue)
            }
        }
    }

}
