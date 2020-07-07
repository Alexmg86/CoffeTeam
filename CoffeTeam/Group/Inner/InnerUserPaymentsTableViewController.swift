//
//  InnerUserPaymentsTableViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 26.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import SwiftyJSON

class InnerUserPaymentsTableViewController: UITableViewController {

    var items = [JSON]()
    var selectedItem: JSON = []
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "userPaymentInfo", for: indexPath) as! InnerUserPaymentsCell
        getSelectedItem(indexPath: indexPath)
        cell.dateLabel.text = selectedItem["created_at"].string
        cell.paymentLabel.text = "+\(selectedItem["payment"].string!)"
        return cell
    }
}
