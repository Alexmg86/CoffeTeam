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
    @IBOutlet weak var paymentsList: UIView!
    @IBOutlet weak var rolesList: UIView!
    var balance: Int = 0
    var userId: Int = 0
    var groupId: String = ""
    let user = User()
    var items = [JSON]()
    var payments = [JSON]()
    var roles = [JSON]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBalance()
        loadItems()
        paymentsList.isHidden = true
        rolesList.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRules), name: NSNotification.Name(rawValue: "updateRules"), object: nil)
    }

    @IBAction func toggleView(_ sender: Any) {
        switch userSegmentControll.selectedSegmentIndex {
        case 0:
            ordersList.isHidden = false
            paymentsList.isHidden = true
            rolesList.isHidden = true
            break
        case 1:
            ordersList.isHidden = true
            paymentsList.isHidden = false
            rolesList.isHidden = true
            break
        case 2:
            ordersList.isHidden = true
            paymentsList.isHidden = true
            rolesList.isHidden = false
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
        let headers: HTTPHeaders = [
            "hash": user.getHash()
        ]
        AF.request(url,
                   method: .post,
                   parameters: ["id": String(userId), "group_id": groupId],
                   headers: headers).responseJSON { [weak self] response in
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
        payments = json["payments"].arrayValue
        roles = json["roles"].arrayValue
        
        let innerVC = self.children[0] as! InnerUserOrdersTableViewController
        innerVC.items = items
        innerVC.tableView.reloadData()

        let innerVC2 = self.children[1] as! InnerUserPaymentsTableViewController
        innerVC2.items = payments
        innerVC2.tableView.reloadData()
        
        let innerVC3 = self.children[2] as! InnerUserRolesTableViewController
        innerVC3.items = roles
        innerVC3.isowner = json["owner"].boolValue
        innerVC3.tableView.reloadData()

        setBalance()
    }

    @objc private func updateRules(notification: NSNotification) {
        let json = JSON(notification.object as Any)
        
        if (!user.isUserExist()) {
            checkItems(value: [])
            return
        }
        let url = "https://ineedapp.ru/access"
        let headers: HTTPHeaders = [
            "hash": user.getHash()
        ]
        AF.request(url,
                   method: .post,
                   parameters: [
                       "group_id": groupId,
                       "role_id": json["roleId"].stringValue,
                       "user_id": String(userId),
                       "switch": json["switch"].stringValue
                   ],
                   headers: headers).responseJSON { response in
            switch response.result {
            case .success( _): break
            case .failure(let error):
                print(error)
            }
        }
    }

    @IBAction func addPayment(_ sender: Any) {
    }

    @IBAction func sentNotification(_ sender: Any) {
    }

}
