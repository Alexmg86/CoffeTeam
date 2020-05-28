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

class ShopAddViewController: UIViewController {
    
    @IBOutlet weak var pickerTextField : CustomInputField!
    
    var pickerOficinas: CustomPickerInput!
    
    var salutations: JSON = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadGroups()
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
                self?.pickerTextField.loadDropdownData(data: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func getData(_ sender: Any) {
        print(pickerTextField.text as Any)
        print(salutations[pickerTextField.tag])
    }

}

extension UITextField {
    func loadDropdownData(data: JSON) {
        self.inputView = CustomPickerInput(frame: CGRect(), pickerData: data, dropdownField: self)
    }
}
