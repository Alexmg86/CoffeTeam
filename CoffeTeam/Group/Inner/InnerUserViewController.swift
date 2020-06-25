//
//  InnerUserViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 25.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class InnerUserViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet  var userSegmentControll: UISegmentedControl!
    var balance: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBalance()
    }
    
    func setBalance() {
        balanceLabel.text = String(balance)
        if balance >= 0 {
            balanceLabel.textColor = #colorLiteral(red: 0.3450980392, green: 0.5882352941, blue: 0.5450980392, alpha: 1)
        }
    }
    
    @IBAction func addPayment(_ sender: Any) {
    }
    @IBAction func sentNotification(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
