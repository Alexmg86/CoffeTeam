//
//  GroupInnerViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 10.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GroupInnerViewController: UIViewController {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var userListView: UIView!
    
    var groupName: String = ""
    var groupCode: String = ""
    var groupId: String = ""
    var items = [JSON]()
    var stats = [JSON]()
    let user = User()
    let modelName = "group"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = groupName
        code.text = groupCode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItems()
    }
    @IBAction func toggleView(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            userListView.isHidden = false
            break
        case 1:
            userListView.isHidden = true
            break
        default:
            break
        }
    }
    
    func loadItems() {
        if (!user.isUserExist()) {
            checkItems(value: [])
            return
        }
        AF.request("https://ineedapp.ru/\(modelName)/\(groupId)").responseJSON { [weak self] (response) in
            switch response.result {
            case .success(let value):
                self?.checkItems(value: value)
            case .failure(let error):
                print(error)
            }
        }
    }
    @IBAction func copyGroup(_ sender: Any) {
        UIPasteboard.general.string = groupCode
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupNewGroup") as! PopUpNewGroupViewController
        popOverVC.wNumber = groupCode
        popOverVC.wSubtitle = "Код скопирован!\nОтправьте его своим коллегам,\nчтобы они могли найти группу."
        self.addChild(popOverVC)
        popOverVC.view.frame = (self.view.frame)
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
    func checkItems(value: Any) {
        let json = JSON(value as Any)
        items = json["users"].arrayValue
        stats = json["users"].arrayValue
        let innerVC = self.children[0] as! InnerTableViewController
        innerVC.items = items
        innerVC.tableView.reloadData()
    }
}
