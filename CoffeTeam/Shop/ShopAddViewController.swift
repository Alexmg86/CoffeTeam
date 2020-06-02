//
//  ShopViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 27.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShopAddViewController: KeyboadController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var iconsCollectionView: UICollectionView!

    @IBOutlet weak var group_idTextField : CustomInputField!
    @IBOutlet weak var nameTextField : CustomInputField!
    @IBOutlet weak var priceTextField : CustomInputField!

    @IBOutlet weak var icon_id: UILabel!
    @IBOutlet weak var group_id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!

    @IBOutlet weak var saveGood: CustomButton!

    var pickerOficinas: CustomPickerInput!
    var salutations: JSON = []
    var icons = [Int]()
    var selectedIcon: Int = 0
    var editData: Any = []
    var goodId: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createIconsList()
        self.iconsCollectionView.delegate = self
        self.iconsCollectionView.dataSource = self
        self.priceTextField.keyboardType = .decimalPad
        group_idTextField.delegate = self
        nameTextField.delegate = self
        priceTextField.delegate = self
        group_id.text = "Группа"
        name.text = "Краткое название"
        price.text = "Цена за 10 единицу"
        setupEdit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadGroups()
    }
    
    func createIconsList() {
        for i in 1...15 {
            icons.append(i)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = iconsCollectionView.dequeueReusableCell(withReuseIdentifier: "shopIconsCell", for: indexPath) as! ShopIconsCollectionViewCell
        cell.iconImage.image = UIImage(named: String(icons[indexPath.row]))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = iconsCollectionView.cellForItem(at: indexPath) as? ShopIconsCollectionViewCell {
            UIView.animate(withDuration: 0.1, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }, completion: { finish in
                UIView.animate(withDuration: 0.05, animations: {
                    cell.transform = CGAffineTransform.identity
                })
            })
        }
        selectedIcon = indexPath.row + 1
        iconError(type: false)
    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func loadGroups() {
        AF.request("https://ineedapp.ru/group").responseJSON { [weak self] (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self?.salutations = json
                self?.group_idTextField.loadDropdownData(data: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func iconError(type: Bool) {
        if let label = self.value(forKey: "icon_id") as? CustomLabel {
            label.errorText = type ? "Не выбрана иконка." : "Иконка"
            label.error = type
        }
    }
    
    func setupEdit() {
        let json = JSON(editData as Any)
        if json.count > 0 {
            print(json)
            goodId = json["id"].int!
            group_idTextField.tag = json["group_id"].int!
            nameTextField.text = json["name"].string
            priceTextField.text = json["price"].string
            selectedIcon = Int(json["icon_id"].string!)!
            let indexPath = IndexPath(row: selectedIcon - 1, section: 0)
            iconsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
            saveGood.setTitle("Изменить", for: .normal)
        }
    }

    @IBAction func saveGoodTapped(_ sender: UIButton) {
        guard 0 < selectedIcon && selectedIcon < 15 else {
            iconError(type: true)
            return
        }
        guard let name = nameTextField.text, let price = priceTextField.text, name != "", price != "" else { return }
        let group_id = group_idTextField.tag
        let good = Goods(icon_id: selectedIcon, group_id: group_id, name: name, price: price)
        var url = "https://ineedapp.ru/good"
        if goodId > 0 {
            url += "/\(String(goodId))"
        }
        AF.request(url,
                   method: goodId > 0 ? .put : .post,
                   parameters: good,
                   encoder: JSONParameterEncoder.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value as Any)
                let status = response.response!.statusCode
                switch status {
                case 422:
                    for (key, error) in json {
                        self?.callError(key: key, errors: error)
                    }
                case 200:
                    print(json)
                    self?.dismiss(animated: true, completion: nil)
                default:
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension UITextField {
    func loadDropdownData(data: JSON) {
        self.inputView = CustomPickerInput(frame: CGRect(), pickerData: data, dropdownField: self)
    }
}

