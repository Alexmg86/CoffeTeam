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

    @IBOutlet weak var groupName: CustomInputField!
    let user = User()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func buttonAdd(_ sender: Any) {
        let hash = user.getHash()
        guard let name = groupName.text, name != "", hash != "" else { return }
        weak var pvc = self.presentingViewController
        AF.request("https://ineedapp:8890/group",
                   method: .post,
                   parameters: ["name": name, "hash": hash],
                   encoder: JSONParameterEncoder.default).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value as Any)
                self?.dismiss(animated: true, completion: {
                    let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupNewGroup") as! PopUpNewGroupViewController
                    popOverVC.wNumber = json["code"].stringValue
                    pvc?.addChild(popOverVC)
                    popOverVC.view.frame = (pvc?.view.frame)!
                    pvc?.view.addSubview(popOverVC.view)
                    popOverVC.didMove(toParent: pvc)
                })
            case .failure(let error):
                print(error)
            }
        }
    }
}
