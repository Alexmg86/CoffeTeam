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

    var selectedRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        super.popupIcon = "groups"
        super.popupTitle = "Группы"
        super.popupSubtitle = "Вы можете создавать группы\nили искать уже имеющиеся."
        super.modelName = "group"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupListCell", for: indexPath) as! GroupTableViewCell
        let item = items[indexPath.row]
        cell.nameLabel.text = item["name"].string
        cell.codeLabel.text = "@\(item["code"])"
        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { [weak self] (action, sourceView, completionHandler) in
            self?.callAlert(row: indexPath.row)
            completionHandler(false)
        }
        let edit = UIContextualAction(style: .normal, title: "Изменить") { [weak self] (action, sourceView, completionHandler) in
            self?.selectedRow = indexPath.row
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
            let item = items[selectedRow]
            let controller = segue.destination as! GroupAddViewController
            controller.editData = JSON(item as Any)
        }
    }

    func callAlert(row: Int) {
        let alert = UIAlertController(title: "Внимание!", message: "Будут удалены также все товары этой группы, но они останутся в статистиках, если по ним были покупки.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { [weak self] action in
            self?.deleteItem(row: row)
        }))
        self.present(alert, animated: true)
    }

    func deleteItem(row: Int) {
        let hash = user.getHash()
        let item = items[row]
        let url = "https://ineedapp.ru/group/\(String(item["id"].int!))"
        AF.request(url,
                    method: .delete,
                    parameters: ["hash": hash],
                    encoder: JSONParameterEncoder.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.checkItems(value: value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
