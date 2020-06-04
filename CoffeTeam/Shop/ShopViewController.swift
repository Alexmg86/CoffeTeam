//
//  ShopViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 28.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShopViewController: MainTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.popupIcon = "groups"
        super.popupTitle = "Лавка"
        super.popupSubtitle = "В лавке явно не хватает кофе.\nНужно срочно добавить!"
        super.modelName = "good"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[section]["goods"].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopListCell", for: indexPath) as! ShopTableViewCell
        let itemSection = items[indexPath.section]
        let item = itemSection["goods"][indexPath.row]
        cell.goodName.text = item["name"].string
        cell.goodPrice.text = item["price"].string
        cell.goodImage.image = UIImage(named: item["icon_id"].string!)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "shopAddView",sender: self)
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width, height: 50))
        label.text = items[section]["name"].string
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        view.addSubview(label)
        return view
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shopAddView" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let itemSection = items[indexPath.section]
            let item = itemSection["goods"][indexPath.row]

            let controller = segue.destination as! ShopAddViewController
            controller.editData = item
        }
    }
}
