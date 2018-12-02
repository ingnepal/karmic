//
//  WelcomeView2ViewController.swift
//  MoonSign
//
//  Created by Mac on 11/18/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class WelcomeView2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func getStartedClicked(_ sender: Any) {
        let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.openDashboard()
    }
}
