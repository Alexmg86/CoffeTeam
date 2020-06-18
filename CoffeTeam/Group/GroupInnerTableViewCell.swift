//
//  GroupInnerTableViewCell.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 18.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class GroupInnerTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        contentView.backgroundColor = UIColor.white
    }
}
