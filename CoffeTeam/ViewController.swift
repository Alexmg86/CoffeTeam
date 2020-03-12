//
//  ViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 10.03.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        starPresentation()
    }

    func starPresentation() {
        if let pScreen = storyboard?.instantiateViewController(identifier: "WPViewController") as? WPViewController {
            pScreen.modalPresentationStyle = .fullScreen
            present(pScreen, animated: true, completion: nil)
        }
    }
        
}

