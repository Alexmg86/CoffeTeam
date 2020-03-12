//
//  WPViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 11.03.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class WPViewController: UIPageViewController {
    
    let wImageViewList = ["welcome_1", "welcome_2", "welcome_3"]
    let wMainTitleList = ["Все дело в зёрнах!", "Создайте команду", "Уведомляйте коллег"]

    override func viewDidLoad() {
        super.viewDidLoad()

        if let wScreen = showViewControllerAtIndex(0) {
            setViewControllers([wScreen], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> WCViewController? {
        guard index >= 0 else { return nil }
        guard index < wMainTitleList.count else { return nil }
        guard let wScreen = storyboard?.instantiateViewController(withIdentifier: "WCViewController") as? WCViewController else { return nil }
        
        wScreen.wImageView = wImageViewList[index]
        wScreen.wMainTitle = wMainTitleList[index]
        wScreen.currentPage = index
        wScreen.numberOfPages = wMainTitleList.count
        
        return wScreen
    }

}
