//
//  MainViewController.swift
//  MoonSign
//
//  Created by @aashutoshrestha on 9/6/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//


//#500F9F hex accent // UIColor(red:0.31, green:0.06, blue:0.62, alpha:1.0) accent


import UIKit
import UserNotifications

class MainViewController: UIViewController {

    @IBOutlet weak var titleBarView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var chatView: UIView!
    
    
    var chatState : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
//        Utility.ENABLE_IQKEYBOARD()
//       SaveData.setFirstLogin(flag: true)
        
        self.titleBarView.layer.zPosition = .greatestFiniteMagnitude
        
        print(SaveData.isLoggedIn())
        if SaveData.isLoggedIn() == false{
            self.fetchCustomer()
        }
        else{
            print("...........isLoggedIn............")
            print(SaveData.getCustomerID())
            let screenSize = UIScreen.main.bounds
            let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController")
            addChildViewController(controller)
            controller.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-70)
            self.chatView.addSubview(controller.view)
            controller.didMove(toParentViewController: self)
        }
        
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(navigation(notification:)), name: .navigation, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        
        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(menuClicked(gesture:)))
        self.menuImage.isUserInteractionEnabled = true
        self.menuImage.addGestureRecognizer(menuTapGesture)
        
        let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileClicked(gesture:)))
        self.profileImage.isUserInteractionEnabled = true
        self.profileImage.addGestureRecognizer(profileTapGesture)
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
       
    }
    @objc func menuClicked(gesture: UITapGestureRecognizer){
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.drawerController.setDrawerState(.opened, animated: true)
    }
    
    @objc func profileClicked(gesture: UITapGestureRecognizer){
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
        self.navigationController?.pushViewController(controller, animated: true)
//        controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.present(controller, animated: true, completion: nil)
        print("***************************Something is Happening************************************")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func navigation(notification: NSNotification){
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        switch (notification.object) as! Int {
        case 1:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "HoroscopeViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 2:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "YogaViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 0:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "ThoughtOfDayViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 3 :
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "AstrologersListViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 4:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "CustomerSupportViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 5:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "HowMoonSIgnWorksViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        default:
            break
        }
        
    }
    
    func fetchCustomer(){
        if SaveData.isLoggedIn() == false{
            let stringURL:String = "https://app.moonsign.org/api/customers/CreateCustomer"
            var parameters:[String:AnyObject]?
            parameters = [
                "DeviceToken": "sdsajdsji12" as AnyObject,
                "MacAddress": UIDevice.current.identifierForVendor?.uuidString as AnyObject
                ] as [String : AnyObject]
            print(parameters as AnyObject)
            
            HTTPRequests.HTTPPostRequestData(stringURL,parameters: parameters!,withSuccess: {(responseDic, Statusflag) in
                if Statusflag {
                    do{
                        let rootData = try JSONDecoder().decode(CreateCustomerRoot.self, from: responseDic!)
                        
                        if rootData.meta?.status! ?? false == true{
                            SaveData.setLoggedIn(flag: true)
                            SaveData.setCustomerID(id: "\(rootData.data?.customerDetail?.id! ?? 0)")
                        }
                        
                        let screenSize = UIScreen.main.bounds
                        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController")
                        self.addChildViewController(controller)
                        controller.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-70)
                        self.chatView.addSubview(controller.view)
                        controller.didMove(toParentViewController: self)
                    }
                    catch let jsonerror{
                        print(jsonerror as Any)
                    }
                    
                    
                }
            })
            
        }
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
extension Notification.Name {
    static let navigation = Notification.Name("navigation")
}
