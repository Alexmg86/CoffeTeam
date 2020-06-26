//
//  InnerUserRolesTableViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 26.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import SwiftyJSON

class InnerUserRolesTableViewController: UITableViewController {

    var items = [JSON]()
    var selectedItem: JSON = []
    var isowner: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
    
    func getSelectedItem(indexPath: IndexPath) {
        selectedItem = items[indexPath.row]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.isEmpty ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userRoleInfo", for: indexPath) as! InnerUserRolesTableCell
        getSelectedItem(indexPath: indexPath)
        cell.nameLabel.text = selectedItem["name"].string
        cell.roleSwitch.setOn(selectedItem["can"].boolValue, animated: true)
        cell.isowner = isowner
        return cell
    }

}
