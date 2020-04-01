//
//  WCViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 11.03.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class WCViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var createAccount: CustomButton!
    @IBOutlet weak var enterAccountBtn: UIButton!
    
    var wImageView = ""
    var wMainTitle = ""
    var wSubTitle = ""
    var currentPage = 0
    var numberOfPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: wImageView)
        mainTitle.text = wMainTitle
        subTitle.text = wSubTitle
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
        
        if currentPage == 2 {
            createAccount.setTitle("Начать", for: .normal)
            enterAccountBtn.isHidden = true
        }
    }
    
    @IBAction func closePresentation(_ sender: UIButton) {
        if currentPage == 2 {
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "presentationShowed")
            dismiss(animated: true, completion: nil)
        } else {
//            dismiss(animated: true, completion: nil)
//            if let pScreen = storyboard?.instantiateViewController(identifier: "RegistrationOne") as? RegistrationViewController {
//                pScreen.modalPresentationStyle = .fullScreen
//                present(pScreen, animated: true, completion: nil)
//            }
            performSegue(withIdentifier: "RegistrationOne", sender: self)
        }
    }
}
