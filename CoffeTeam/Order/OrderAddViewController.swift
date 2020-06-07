//
//  OrderAddViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 05.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class OrderAddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var orderTableView: UITableView!
    var items = [JSON]()
    let user = User()
    let modelName = "good"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.orderTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: orderTableView.frame.size.width, height: 1))
        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
        loadItems()
    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func loadItems() {
        if (!user.isUserExist()) {
            checkItems(value: [])
            return
        }
        AF.request("https://ineedapp.ru/\(modelName)").responseJSON { [weak self] (response) in
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
        items = json.arrayValue
        orderTableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.isEmpty ? 0 : items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[section]["goods"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: "orderAddListCell", for: indexPath) as! OrderAddTableViewCell
        let itemSection = items[indexPath.section]
        let item = itemSection["goods"][indexPath.row]
        cell.goodName.text = item["name"].string
        cell.goodPrice.text = item["price"].string
        cell.goodImage.image = UIImage(named: item["icon_id"].string!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width, height: 50))
        label.text = items[section]["name"].string
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemSection = items[indexPath.section]
        let item = itemSection["goods"][indexPath.row]
        let group_id = String(itemSection["id"].int!)
        let price = item["price"].string
        let good = String(item["id"].int!)
        let hash = user.getHash()
        
        AF.request("https://ineedapp.ru/order",
                   method: .post,
                   parameters: ["group": group_id, "good": good, "price": price, "hash": hash],
                   encoder: JSONParameterEncoder.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let _):
                self?.dismiss(animated: true, completion: nil)
            case .failure(let error):
                print(error)
            }
        }
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
