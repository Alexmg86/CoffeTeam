//
//  GroupAddViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 10.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GroupAddViewController: KeyboadController {

    @IBOutlet weak var saveGroup: CustomButton!
    @IBOutlet weak var nameTextField: CustomInputField!
    @IBOutlet weak var name: UILabel!
    
    var editData: JSON = []
    var editDataCount: Int = 0

    let user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        name.text = "Название группы"
        setupEdit()
    }
    
    func setupEdit() {
        if editData.count > 0 {
            nameTextField.text = editData["name"].string
            saveGroup.setTitle("Изменить", for: .normal)
            editDataCount = editData.count
        }
    }
    
    func showDonePopup(code: String) {
        weak var pvc = self.presentingViewController
        self.dismiss(animated: true, completion: {
            if self.editDataCount == 0 {
                let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupNewGroup") as! PopUpNewGroupViewController
                popOverVC.wNumber = code
                pvc?.addChild(popOverVC)
                popOverVC.view.frame = (pvc?.view.frame)!
                pvc?.view.addSubview(popOverVC.view)
                popOverVC.didMove(toParent: pvc)
            }
        })
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func buttonAdd(_ sender: Any) {
        let hash = user.getHash()
        guard let name = nameTextField.text, name != "", hash != "" else { return }
        
        var url = "https://ineedapp.ru/group"
        if editDataCount > 0 {
            url += "/\(String(editData["id"].int!))"
        }
        AF.request(url,
                   method: editData.count > 0 ? .put : .post,
                   parameters: ["name": name, "hash": hash],
                   encoder: JSONParameterEncoder.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value as Any)
                self?.showDonePopup(code: json["code"].stringValue)
            case .failure(let error):
                print(error)
            }
        }
    }
}
