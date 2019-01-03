//
//  CustomerSupportViewController.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class CustomerSupportViewController: UIViewController {
    @IBOutlet weak var callUsButton: UIButton!
    @IBOutlet weak var emailUsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.callUsButton.backgroundColor = ColorConstants.primaryColor
        self.emailUsButton.backgroundColor = ColorConstants.primaryColor
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Customer Support"
    }
    

    @IBAction func callUsClicked(_ sender: Any) {
        let tel = "+18573422792"
        if let url = URL(string: "tel:\(tel)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    @IBAction func emailUsClicked(_ sender: UIButton) {
        
        let email = "moonsign@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    

}
