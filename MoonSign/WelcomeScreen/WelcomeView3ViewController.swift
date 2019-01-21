//
//  WelcomeView3ViewController.swift
//  MoonSign
//
//  Created by Mac on 1/4/19.
//  Copyright © 2019 BlackSpring. All rights reserved.
//

import UIKit

class WelcomeView3ViewController: UIViewController {

    @IBOutlet weak var titleIMage4: UIImageView!
    @IBOutlet weak var titleIMage3: UIImageView!
    @IBOutlet weak var titleIMage2: UIImageView!
    @IBOutlet weak var titleImage1: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleImage1.image = titleImage1.image?.withRenderingMode(.alwaysTemplate)
        titleIMage2.image = titleIMage2.image?.withRenderingMode(.alwaysTemplate)
        titleIMage3.image = titleIMage3.image?.withRenderingMode(.alwaysTemplate)
        titleIMage4.image = titleIMage4.image?.withRenderingMode(.alwaysTemplate)
        
        titleImage1.tintColor = ColorConstants.primaryColor
         titleIMage2.tintColor = ColorConstants.primaryColor
         titleIMage3.tintColor = ColorConstants.primaryColor
         titleIMage4.tintColor = ColorConstants.primaryColor
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
