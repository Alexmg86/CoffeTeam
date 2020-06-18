//
//  GroupInnerViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 10.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GroupInnerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var groupName: String = ""
    var groupCode: String = ""
    var groupId: String = ""
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var usersList: UITableView!
    var items = [JSON]()
    var selectedItem: JSON = []
    let user = User()
    let modelName = "group"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usersList.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: usersList.frame.size.width, height: 1))
        self.title = groupName
        code.text = groupCode
        self.usersList.delegate = self
        self.usersList.dataSource = self
        loadItems()
    }
    
    func loadItems() {
        if (!user.isUserExist()) {
            checkItems(value: [])
            return
        }
        AF.request("https://ineedapp.ru/\(modelName)/\(groupId)").responseJSON { [weak self] (response) in
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
        usersList.reloadData()
    }
    
    func getSelectedItem(indexPath: IndexPath, relation: String) {
        let itemSection = items[indexPath.section]
        selectedItem = itemSection[relation][indexPath.row]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.isEmpty ? 0 : items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[section]["users"].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersList.dequeueReusableCell(withIdentifier: "usersListCell", for: indexPath) as! GroupInnerTableViewCell
        getSelectedItem(indexPath: indexPath, relation: "users")
        cell.nameLabel.text = selectedItem["name"].string
        cell.contactLabel.text = selectedItem["email"].string
        let total = selectedItem["total"].int!
        cell.countLabel.text = String(total)
        if total >= 0 {
            cell.countLabel.textColor = #colorLiteral(red: 0.3450980392, green: 0.5882352941, blue: 0.5450980392, alpha: 1)
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }

}
