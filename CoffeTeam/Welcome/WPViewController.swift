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
    let wSubTitleList = [
        "Ведите учет ваших вкусняшек и кофе.\nТеперь каждый решает сколько\nскинуться на капучино или пряник.",
        "Добавьте в команду своих коллег,\nнаполните лавку продуктами\nи наслаждайтесь кофе.",
        "Когда настанет момент пополнять запасы,\nвы можете уведомить коллег об этом,\nа система отразит кто сколько должен"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self

        if let wScreen = showViewControllerAtIndex(0) {
            setViewControllers([wScreen], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> WCViewController? {
        guard index >= 0 else { return nil }
        guard index < wMainTitleList.count else {
//            let userDefaults = UserDefaults.standard
//            userDefaults.set(true, forKey: "presentationShowed")
            dismiss(animated: true, completion: nil)
            return nil
        }
        guard let wScreen = storyboard?.instantiateViewController(withIdentifier: "WCViewController") as? WCViewController else { return nil }
        
        wScreen.wImageView = wImageViewList[index]
        wScreen.wMainTitle = wMainTitleList[index]
        wScreen.wSubTitle = wSubTitleList[index]
        wScreen.currentPage = index
        wScreen.numberOfPages = wMainTitleList.count
        
        return wScreen
    }

}

extension WPViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! WCViewController).currentPage
        pageNumber -= 1
        return showViewControllerAtIndex(pageNumber)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var pageNumber = (viewController as! WCViewController).currentPage
        pageNumber += 1
        return showViewControllerAtIndex(pageNumber)
    }
    
}
