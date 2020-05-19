//
//  GroupAddViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 10.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit
import Firebase

class GroupAddViewController: KeyboadController {

    var ref: DatabaseReference!
    @IBOutlet weak var groupName: CustomInputField!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func buttonAdd(_ sender: Any) {
        let hexValue = String(format:"%02X", Int64(Date().timeIntervalSince1970))
        guard let user = Auth.auth().currentUser, let name = groupName.text else { return }

        let reference = ref.child("groups").childByAutoId()
        let groupId: String = reference.key!
        reference.setValue(["name": name, "code": hexValue, "owner": user.uid])
        ref.child("users").child(user.uid).child("groups").child(groupId).setValue(true)
        
//        self.dismiss(animated: true, completion: {
//            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popupRegistration") as! PopUpRegistrationViewController
//            pvc?.addChild(popOverVC)
//            popOverVC.view.frame = (pvc?.view.frame)!
//            pvc?.view.addSubview(popOverVC.view)
//            popOverVC.didMove(toParent: pvc)
//        })
    }
}
