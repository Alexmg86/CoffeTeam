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

    override func viewDidLayoutSubviews() {
       tableView.isScrollEnabled = tableView.contentSize.height > tableView.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.callPopup()
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadGroups()
    }
    
    func loadGroups() {
        AF.request("https://ineedapp:8890/group").responseJSON { [weak self] (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self?.items = json.arrayValue
                self?.checkPopup()
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkPopup() {
        if (items.count > 0) {
            for view in self.view.subviews {
                view.removeFromSuperview()
            }
        }
    }

    func callPopup() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupMain") as! PopUpMainViewController
        self.addChild(popOverVC)
        popOverVC.wPopipImage = "groups"
        popOverVC.wPopipTitle = "Группы"
        popOverVC.wPopipSubTitle = "Вы можете создавать группы\nили искать уже имеющиеся."
        popOverVC.view.frame = (self.view.frame)
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
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
