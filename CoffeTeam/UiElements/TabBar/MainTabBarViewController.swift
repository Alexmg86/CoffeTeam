//
//  MainTabBatViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 05.04.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class MainTabBarViewController: BubbleTabBarController {
    
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = #colorLiteral(red: 0.8509803922, green: 0.6196078431, blue: 0.5882352941, alpha: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        starPresentation()
    }
    
    func starPresentation() {
            let isShowed = userDefaults.bool(forKey: "presentationShowed")
            if isShowed == false {
                if let pScreen = storyboard?.instantiateViewController(identifier: "WPViewController") as? WPViewController {
                    pScreen.modalPresentationStyle = .fullScreen
                    present(pScreen, animated: true, completion: nil)
                }
            }
//            userDefaults.set(false, forKey: "presentationShowed")
        }
}
