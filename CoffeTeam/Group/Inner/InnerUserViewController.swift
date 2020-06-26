//
//  InnerUserViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 25.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class InnerUserViewController: UIViewController {

    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet  var userSegmentControll: UISegmentedControl!
    @IBOutlet weak var ordersList: UIView!
    var balance: Int = 0
    var userHash: String = ""
    var groupId: String = ""
    let user = User()
    var items = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBalance()
        loadItems()
    }

    @IBAction func toggleView(_ sender: Any) {
        switch userSegmentControll.selectedSegmentIndex {
        case 0:
            ordersList.isHidden = false
//            statListView.isHidden = true
            break
        case 1:
            ordersList.isHidden = true
//            statListView.isHidden = false
            break
        case 2:
            ordersList.isHidden = true
            break
        default:
            break
        }
    }
    
    func setBalance() {
        balanceLabel.text = String(balance)
        if balance >= 0 {
            balanceLabel.textColor = #colorLiteral(red: 0.3450980392, green: 0.5882352941, blue: 0.5450980392, alpha: 1)
        }
    }
    
    func loadItems() {
        if (!user.isUserExist()) {
            checkItems(value: [])
            return
        }
        let url = "https://ineedapp.ru/user/getstat"
        AF.request(url,
                   method: .post,
                   parameters: ["hash": userHash, "group_id": groupId],
                   encoder: JSONParameterEncoder.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.checkItems(value: value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkItems(value: Any) {
        let json = JSON(value as Any)
        items = json["orders"].arrayValue
//        stats = json["stats"].arrayValue
        let innerVC = self.children[0] as! InnerUserOrdersTableViewController
        innerVC.items = items
        innerVC.tableView.reloadData()
        
        setBalance()
//        let innerVC2 = self.children[1] as! InnerViewController
//        innerVC2.data = stats
//        innerVC2.updateData()
    }

    @IBAction func addPayment(_ sender: Any) {
    }

    @IBAction func sentNotification(_ sender: Any) {
    }

}
