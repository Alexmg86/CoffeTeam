//
//  MainTableViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 04.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainTableViewController: UITableViewController {

    var items = [JSON]()
    let user = User()
    var itemOldCount: Int = 0

    var modelName: String = ""
    var popupIcon: String = ""
    var popupTitle: String = ""
    var popupSubtitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        configureRefreshControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItems()
    }

    /*
     Запрет скрола на случай приветственного попапа при пустых списках.
     */
    override func viewDidLayoutSubviews() {
        tableView.isScrollEnabled = tableView.contentSize.height > tableView.frame.size.height || items.count > 0
    }

    /*
     Загрузка списков. Проверка авторизован ли пользователь, если нет, то передаем пестой массив дальше.
     */
    func loadItems() {
        if (!user.isUserExist()) {
            checkItems(value: [])
            return
        }
        AF.request("https://ineedapp.ru/\(modelName)").responseJSON { [weak self] (response) in
            switch response.result {
            case .success(let value):
                self?.checkItems(value: value)
            case .failure(let error):
                print(error)
            }
        }
    }

    /*
     Проверка списка и показ попапа, если он пустой.
     */
    func checkItems(value: Any) {
        let json = JSON(value as Any)
        items = json.arrayValue
        if let viewWithTag = self.view.viewWithTag(1234) {
            if (items.count == itemOldCount) {
                return
            }
            viewWithTag.removeFromSuperview()
        }
        if (items.count == 0) {
            callPopup()
        }
        itemOldCount = items.count
        tableView.reloadData()
    }

    /*
     Вызов универсального попапа
    */
    func callPopup() {
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupMain") as! PopUpMainViewController
        self.addChild(popOverVC)
        popOverVC.wPopipImage = popupIcon
        popOverVC.wPopipTitle = popupTitle
        popOverVC.wPopipSubTitle = popupSubtitle
        popOverVC.view.frame = (self.view.frame)
        popOverVC.view.tag = 1234
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }

    /*
     Обновление данных при свайпе вниз.
     */
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

    @objc func refreshData() {
        loadItems()
        DispatchQueue.main.async {
           self.tableView.refreshControl?.endRefreshing()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.isEmpty ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.isEmpty ? 0 : items.count
    }
}
