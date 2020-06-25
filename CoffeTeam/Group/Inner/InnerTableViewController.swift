//
//  InnerTableViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 20.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import SwiftyJSON

class InnerTableViewController: UITableViewController {
    
    var items = [JSON]()
    var groupId: String = ""
    var selectedItem: JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }

    func getSelectedItem(indexPath: IndexPath, relation: String) {
        let itemSection = items[indexPath.section]
        selectedItem = itemSection[relation][indexPath.row]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.isEmpty ? 0 : items.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[section]["users"].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersListCell", for: indexPath) as! GroupInnerTableViewCell
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getSelectedItem(indexPath: indexPath, relation: "users")
        let innerUserVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "innerUser") as! InnerUserViewController
        innerUserVC.title = selectedItem["name"].string
        innerUserVC.balance = selectedItem["total"].int!
        innerUserVC.groupId = groupId
        innerUserVC.userHash = selectedItem["hash"].string!
        self.navigationController?.pushViewController(innerUserVC, animated: true)
        print(selectedItem)
    }
}
