//
//  GroupViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 10.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import SwiftyJSON

class GroupViewController: MainTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.popupIcon = "groups"
        super.popupTitle = "Группы"
        super.popupSubtitle = "Вы можете создавать группы\nили искать уже имеющиеся."
        super.modelName = "group"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.isEmpty ? 0 : items.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[section]["items"].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupListCell", for: indexPath) as! GroupTableViewCell
        getSelectedItem(indexPath: indexPath, relation: "items")
        cell.nameLabel.text = selectedItem["name"].string
        cell.codeLabel.text = "@\(selectedItem["code"])"
        cell.countLabel.text = String(selectedItem["count"].int!)
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, sourceView, completionHandler) in
            self?.callAlert(indexPath: indexPath)
            completionHandler(false)
        }
        let edit = UIContextualAction(style: .normal, title: "Изменить") { [weak self] (action, sourceView, completionHandler) in
            self?.getSelectedItem(indexPath: indexPath, relation: "items")
            self?.performSegue(withIdentifier: "groupEdit",sender: self)
            completionHandler(false)
        }
        edit.backgroundColor = .blue
        let swipeAction = UISwipeActionsConfiguration(actions: [delete, edit])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getSelectedItem(indexPath: indexPath, relation: "items")
        self.performSegue(withIdentifier: "groupShow", sender: self)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupEdit" {
            let controller = segue.destination as! GroupAddViewController
            controller.editData = JSON(selectedItem as Any)
        }
        if segue.identifier == "groupShow" {
            let controller = segue.destination as! GroupInnerViewController
            controller.groupName = selectedItem["name"].stringValue
            controller.groupCode = selectedItem["code"].stringValue
            controller.groupId = selectedItem["id"].stringValue
        }
    }

    func callAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Внимание!", message: "Будут удалены также все товары этой группы, но они останутся в статистиках, если по ним были покупки.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] action in
            self?.deleteItem(indexPath: indexPath, column: "id", subsection: "items")
        }))
        self.present(alert, animated: true)
    }
}
