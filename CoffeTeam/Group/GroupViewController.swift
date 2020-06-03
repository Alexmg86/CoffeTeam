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

class GroupViewController: UITableViewController {

    var items = [JSON]()
    let user = User()
    var selectedRow: Int = 0

    func configureRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Обновление данных...")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
    }

    override func viewDidLayoutSubviews() {
        tableView.isScrollEnabled = tableView.contentSize.height > tableView.frame.size.height || items.count > 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        loadGroups()
        self.tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
    @objc func refreshData() {
        loadGroups()
        DispatchQueue.main.async {
           self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadGroups()
    }
    
    func loadGroups() {
        if (!user.isUserExist()) {
            items = []
            checkPopup()
            return
        }
        AF.request("https://ineedapp.ru/group").responseJSON { [weak self] (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self?.items = json.arrayValue
                self?.checkPopup()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkPopup() {
        if let viewWithTag = self.view.viewWithTag(1234) {
            viewWithTag.removeFromSuperview()
        }
        if (items.count == 0) {
            callPopup()
        }
        tableView.reloadData()
    }

    func callPopup() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupMain") as! PopUpMainViewController
        self.addChild(popOverVC)
        popOverVC.wPopipImage = "groups"
        popOverVC.wPopipTitle = "Группы"
        popOverVC.wPopipSubTitle = "Вы можете создавать группы\nили искать уже имеющиеся."
        popOverVC.view.frame = (self.view.frame)
        popOverVC.view.tag = 1234
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
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
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { (action, sourceView, completionHandler) in
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "groupEdit" {
            let item = items[selectedRow]
            let controller = segue.destination as! GroupAddViewController
            controller.editData = JSON(item as Any)
        }
    }
}
