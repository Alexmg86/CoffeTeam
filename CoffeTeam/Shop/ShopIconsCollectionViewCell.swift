//
//  ShopIconsCollectionViewCell.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 28.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class ShopIconsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let selectedView = UIView(frame: bounds)
        selectedView.backgroundColor = UIColor(red: 94/255, green: 186/255, blue: 125/255, alpha: 0.2)
        self.layer.cornerRadius = 10
        self.selectedBackgroundView = selectedView
        self.clipsToBounds = true
    }

}
