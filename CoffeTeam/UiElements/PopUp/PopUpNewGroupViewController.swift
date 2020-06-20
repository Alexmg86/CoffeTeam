//
//  PopUpNewGroupViewController.swift
//  CoffeTeam
//
//  Created by Алексей Морозов on 19.05.2020.
//  Copyright © 2020 Алексей Морозов. All rights reserved.
//

import UIKit

class PopUpNewGroupViewController: UIViewController {
    
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    var wNumber = ""
    var wSubtitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        number.text = wNumber
        subtitle.text = wSubtitle
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.showAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        self.removeAnimate()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished)
                {
                    self.view.removeFromSuperview()
                }
        });
    }

}
