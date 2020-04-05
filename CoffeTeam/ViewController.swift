//
//  ViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 10.03.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard

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
//        userDefaults.set(false, forKey: "presentationShowed")
        
    }
        
}

