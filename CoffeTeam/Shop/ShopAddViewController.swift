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

    @IBOutlet weak var group_id: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!

    @IBOutlet weak var saveGood: CustomButton!

    var pickerOficinas: CustomPickerInput!
    var salutations: JSON = []
    let icons = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    var selectedIcon: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.iconsCollectionView.delegate = self
        self.iconsCollectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadGroups()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = iconsCollectionView.dequeueReusableCell(withReuseIdentifier: "shopIconsCell", for: indexPath) as! ShopIconsCollectionViewCell
        cell.iconImage.image = UIImage(named: String(icons[indexPath.row]))
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.clipsToBounds = true
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = iconsCollectionView.cellForItem(at: indexPath) as? ShopIconsCollectionViewCell {
            cell.contentView.backgroundColor = UIColor(red: 94/255, green: 186/255, blue: 125/255, alpha: 0.2)
        }
        if selectedIcon != indexPath.row {
            selectedIcon = indexPath.row
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = iconsCollectionView.cellForItem(at: indexPath) as? ShopIconsCollectionViewCell {
            cell.contentView.backgroundColor = nil
        }
    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func loadGroups() {
        AF.request("https://ineedapp:8890/group").responseJSON { [weak self] (response) in
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

    @IBAction func saveGoodTapped(_ sender: UIButton) {
        print(group_idTextField.text as Any)
        print(salutations[group_idTextField.tag])
    }
}

extension UITextField {
    func loadDropdownData(data: JSON) {
        self.inputView = CustomPickerInput(frame: CGRect(), pickerData: data, dropdownField: self)
    }
}

