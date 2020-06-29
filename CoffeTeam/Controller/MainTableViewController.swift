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
    var selectedItem: JSON = []
    let user = User()
    var itemOldCount: Int = 0
    var isNeedReload: Bool = true

    var modelName: String = ""
    var popupIcon: String = ""
    var popupTitle: String = ""
    var popupSubtitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        configureRefreshControl()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItems(isNeedReload: isNeedReload)
    }

    /*
     Запрет скрола на случай приветственного попапа при пустых списках.
     */
    override func viewDidLayoutSubviews() {
        tableView.isScrollEnabled = tableView.contentSize.height > tableView.frame.size.height || items.count > 0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.width, height: 50))
        label.text = items[section]["name"].string
        label.font = UIFont.systemFont(ofSize: 22, weight: .light)
        view.backgroundColor = .white
        view.addSubview(label)
        return view
    }

    /*
     Загрузка списков. Проверка авторизован ли пользователь, если нет, то передаем пустой массив дальше.
     */
    func loadItems(isNeedReload: Bool) {
        if !isNeedReload {
            return
        }
        print("111")
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

    func deleteItem(indexPath: IndexPath, column: String, subsection: String) {
        let hash = user.getHash()
        var item = JSON()
        if subsection != "" {
            let itemSection = items[indexPath.section]
            item = itemSection[subsection][indexPath.row]
        } else {
            item = items[indexPath.row]
        }
        let url = "https://ineedapp.ru/\(modelName)/\(String(item[column].int!))"
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
    
    func getSelectedItem(indexPath: IndexPath, relation: String) {
        let itemSection = items[indexPath.section]
        selectedItem = itemSection[relation][indexPath.row]
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
        loadItems(isNeedReload: true)
        DispatchQueue.main.async {
           self.tableView.refreshControl?.endRefreshing()
        }
    }
}
