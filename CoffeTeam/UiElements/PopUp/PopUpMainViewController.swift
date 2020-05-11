//
//  PopUpMainViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 11.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class PopUpMainViewController: UIViewController {
    
    @IBOutlet weak var popupImage: UIImageView!
    @IBOutlet weak var popupTitle: UILabel!
    @IBOutlet weak var popupSubTitle: UILabel!
    
    var wPopipImage = ""
    var wPopipTitle = ""
    var wPopipSubTitle = ""
    
    var heightView: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupTitle.text = wPopipTitle
        popupSubTitle.text = wPopipSubTitle
        popupImage.image = UIImage(named: wPopipImage)
        heightView = self.view.bounds.height - (self.tabBarController?.tabBar.frame.height)! - (self.navigationController?.navigationBar.frame.height)! - 40

        self.showAnimate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.frame.size.height = heightView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        self.removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }

}
