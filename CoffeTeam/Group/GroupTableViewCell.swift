//
//  GroupTableViewCell.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 21.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var countLabel: BadgeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
