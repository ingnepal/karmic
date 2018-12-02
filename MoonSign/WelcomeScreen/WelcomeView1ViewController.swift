//
//  WelcomeView1ViewController.swift
//  MoonSign
//
//  Created by Mac on 11/18/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class WelcomeView1ViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        mainView.layer.shadowColor = UIColor.lightGray.cgColor
        mainView.layer.shadowOpacity = 1.0
        mainView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        mainView.layer.shadowRadius = 3.0
        mainView.layer.backgroundColor = UIColor.clear.cgColor
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
