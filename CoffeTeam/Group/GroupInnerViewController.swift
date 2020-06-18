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

class GroupInnerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var groupName: String = ""
    var groupCode: String = ""
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var usersList: UITableView!
    var items = [JSON]()
    let user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usersList.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: usersList.frame.size.width, height: 1))
        self.title = groupName
        code.text = groupCode
        self.usersList.delegate = self
        self.usersList.dataSource = self
//        loadItems()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.isEmpty ? 0 : items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items[section]["users"].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }

}
