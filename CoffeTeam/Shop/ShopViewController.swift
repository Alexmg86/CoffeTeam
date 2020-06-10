//
//  ShopViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 28.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import SwiftyJSON

class ShopViewController: MainTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.popupIcon = "goods"
        super.popupTitle = "Лавка"
        super.popupSubtitle = "В лавке явно не хватает кофе.\nНужно срочно добавить!"
        super.modelName = "good"
        tableView.allowsSelection = false
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.isEmpty ? 0 : items.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[section]["goods"].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopListCell", for: indexPath) as! ShopTableViewCell
        getSelectedItem(indexPath: indexPath, relation: "goods")
        cell.goodName.text = selectedItem["name"].string
        cell.goodPrice.text = selectedItem["price"].string
        cell.goodImage.image = UIImage(named: selectedItem["icon_id"].string!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, sourceView, completionHandler) in
            self?.deleteItem(indexPath: indexPath, column: "id", subsection: "goods")
            completionHandler(false)
        }
        let edit = UIContextualAction(style: .normal, title: "Изменить") { [weak self] (action, sourceView, completionHandler) in
            self?.getSelectedItem(indexPath: indexPath, relation: "goods")
            self?.performSegue(withIdentifier: "goodEdit",sender: self)
            completionHandler(false)
        }
        edit.backgroundColor = .blue
        let swipeAction = UISwipeActionsConfiguration(actions: [delete, edit])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goodEdit" {
            let controller = segue.destination as! ShopAddViewController
            controller.editData = JSON(selectedItem as Any)
        }
    }
}
