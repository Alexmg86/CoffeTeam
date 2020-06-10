//
//  OrderViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 04.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderViewController: MainTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.popupIcon = "orders"
        super.popupTitle = "Покупки"
        super.popupSubtitle = "Выберите себе кофе или чай,\nа последние операции\nбудут отражены здесь."
        super.modelName = "order"
        super.isNeedReload = false
        loadItems(isNeedReload: true)
        tableView.allowsSelection = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadItems), name: NSNotification.Name(rawValue: "reloadItems"), object: nil)
    }

    @objc private func reloadItems(notification: NSNotification){
        checkItems(value: notification.object as Any)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.isEmpty ? 0 : items.count
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[section]["items"].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ordersListCell", for: indexPath) as! OrderTableViewCell
        getSelectedItem(indexPath: indexPath, relation: "items")
        cell.goodName.text = selectedItem["name"].string
        cell.goodPrice.text = "-\(selectedItem["price"].string!)"
        cell.goodDate.text = selectedItem["created_at"].string
        cell.goodImage.image = UIImage(named: selectedItem["icon_id"].string!)
        return cell
    }
}
