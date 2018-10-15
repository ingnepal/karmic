//
//  ThoughtOfDayViewController.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit

class ThoughtOfDayViewController: UIViewController {
    @IBOutlet weak var thoughtOfDayText: UILabel!
    
    @IBOutlet weak var shareButton: UIButton!
    
    var thoughtOftheDay : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         self.thoughtOfDayText.text = "Thought Of The Day"
        
        self.shareButton.backgroundColor = ColorConstants.primaryColor
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Thought of the day"
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData(){
        let stringURL : String = HTTPConstants.baseURl + "api/horoscope/GetThoughtOfTheDay"
        
        HTTPRequests.HTTPGetRequestData(stringURL) { (response, statusFlag) in
            
            do{
                let root = try JSONDecoder().decode(GetThoughtRoot.self, from: response!)
                if root.meta?.status ?? false == true{
                    self.thoughtOfDayText.text = root.data?.thoughtOfTheDay ?? "MoonSign"
                    self.thoughtOftheDay = "\(root.data?.thoughtOfTheDay! ?? "MoonSign") - MoonSign"
                }
            }
            catch let jsonerror{
                print(jsonerror)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func shareClicked(_ sender: UIButton) {
        let textShare = [ thoughtOftheDay ]
        let activityViewController = UIActivityViewController(activityItems: textShare as [Any] , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
