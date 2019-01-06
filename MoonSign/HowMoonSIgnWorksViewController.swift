//
//  HowMoonSIgnWorksViewController.swift
//  MoonSign
//
//  Created by Mac on 9/9/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class HowMoonSIgnWorksViewController: UIViewController {

    @IBOutlet weak var getAnswerImage: UIImageView!
    @IBOutlet weak var astrologerImage: UIImageView!
    @IBOutlet weak var askQuestionImage: UIImageView!
    @IBOutlet weak var shareBirthImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Moon Sign"
        
        getAnswerImage.image = getAnswerImage.image?.withRenderingMode(.alwaysTemplate)
        astrologerImage.image = astrologerImage.image?.withRenderingMode(.alwaysTemplate)
        askQuestionImage.image = askQuestionImage.image?.withRenderingMode(.alwaysTemplate)
        shareBirthImage.image = shareBirthImage.image?.withRenderingMode(.alwaysTemplate)
        
        getAnswerImage.tintColor = ColorConstants.primaryColor
        astrologerImage.tintColor = ColorConstants.primaryColor
        askQuestionImage.tintColor = ColorConstants.primaryColor
        shareBirthImage.tintColor = ColorConstants.primaryColor
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
