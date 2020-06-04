//
//  GroupViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 10.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
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
        return items.isEmpty ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupListCell", for: indexPath) as! GroupTableViewCell
        let item = items[indexPath.row]
        cell.nameLabel.text = item["name"].string
        cell.codeLabel.text = "@\(item["code"])"
        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, sourceView, completionHandler) in
            self?.callAlert(indexPath: indexPath)
            completionHandler(false)
        }
        let edit = UIContextualAction(style: .normal, title: "Изменить") { [weak self] (action, sourceView, completionHandler) in
            self?.selectedIndex = indexPath
            self?.performSegue(withIdentifier: "groupEdit",sender: self)
            completionHandler(false)
        }
        edit.backgroundColor = .blue
        let swipeAction = UISwipeActionsConfiguration(actions: [delete, edit])
        swipeAction.performsFirstActionWithFullSwipe = false
        return swipeAction
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupEdit" {
            let item = items[selectedIndex.row]
            let controller = segue.destination as! GroupAddViewController
            controller.editData = JSON(item as Any)
        }
    }

    func callAlert(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Внимание!", message: "Будут удалены также все товары этой группы, но они останутся в статистиках, если по ним были покупки.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] action in
            self?.deleteItem(indexPath: indexPath, column: "id", subsection: "")
        }))
        self.present(alert, animated: true)
    }
}
