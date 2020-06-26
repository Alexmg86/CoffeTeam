//
//  InnerUserOrdersTableCell.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 26.06.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class InnerUserOrdersTableCell: UITableViewCell {

    @IBOutlet weak var goodPrice: UILabel!
    @IBOutlet weak var goodName: UILabel!
    @IBOutlet weak var goodDate: UILabel!
    @IBOutlet weak var goodImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
