//
//  CustomPickerInput.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 28.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import SwiftyJSON

class CustomPickerInput: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    var pickerData = JSON()
    var pickerTextField : UITextField!

    init(frame: CGRect, pickerData: JSON, dropdownField: UITextField) {
        super.init(frame: frame)
        self.pickerData = pickerData
        self.pickerTextField = dropdownField

        self.delegate = self
        self.dataSource = self

        if pickerData.count > 0 {
            self.pickerTextField.text = self.pickerData[0]["name"].string
            self.pickerTextField.tag = self.pickerData[0]["id"].int!
            self.pickerTextField.isEnabled = true
        } else {
            self.pickerTextField.text = nil
            self.pickerTextField.isEnabled = false
        }

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = pickerData[row]
        return item["name"].string
    }

    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = pickerData[row]
        pickerTextField.text = item["name"].string
        pickerTextField.tag = item["id"].int!
    }
}
