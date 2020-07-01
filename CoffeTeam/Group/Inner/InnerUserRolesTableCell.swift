//
//  InnerUserRolesTableCell.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 26.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class InnerUserRolesTableCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleSwitch: UISwitch!
    
    var isowner: Bool = false {
        didSet {
            if (isowner) {
                roleSwitch.isEnabled = false
            } else {
                roleSwitch.isEnabled = true
            }
        }
    }
    
    var roleId: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func toggleRole(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateRules"), object: ["switch": roleSwitch.isOn, "roleId": roleId])
    }
    
}
