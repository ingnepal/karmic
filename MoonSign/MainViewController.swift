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

class MainViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var messageText: UITextView!
//    @IBOutlet weak var titleBarView: UIView!
//    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var chatView: UIView!
//    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var messageBubble: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    
    var chatState : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utility.ENABLE_IQKEYBOARD()
//       SaveData.setFirstLogin(flag: true)
        
//        self.titleBarView.layer.zPosition = .greatestFiniteMagnitude
//        self.titleBarView.backgroundColor = ColorConstants.primaryColor
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.messageText.delegate = self
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "menu"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(menuClicked(gesture:)), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
//        item1.title = "Moonsign"
        
        self.navigationItem.setLeftBarButton(item1, animated: true)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "user"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        btn2.addTarget(self, action: #selector(profileClicked(gesture:)), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setRightBarButton(item2, animated: true)
        
       
        self.messageText.layer.borderWidth = 1
        self.messageText.layer.borderColor = UIColor.lightGray.cgColor
        self.messageText.layer.cornerRadius = 5
        
        self.messageText.text = "← Ideas what to ask"
        self.messageText.textColor = UIColor.lightGray
        self.messageBubble.setImage(UIImage(named: "speech-bubble")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.messageBubble.tintColor = ColorConstants.primaryColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(navigation(notification:)), name: .navigation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setTemplate(notification:)), name: .getTemplateNotification, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        print(SaveData.isLoggedIn())
        if SaveData.isLoggedIn() == false{
            SaveData.setRegisteredStatus(flag: false)
            self.fetchCustomer()
            self.navigationItem.title = "Updating First time..."
        }
        else{
            if chatState == 0 {
                print("...........isLoggedIn............")
                print(SaveData.getCustomerID())
                let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController")
                addChildViewController(controller)
                controller.view.frame = CGRect(x: 0, y: 0, width: chatView.frame.width, height: chatView.frame.height-30)
                self.chatView.addSubview(controller.view)
                controller.didMove(toParentViewController: self)
                self.navigationItem.title = "Moonsign"
                
                chatState = 1
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        
//        let menuTapGesture = UITapGestureRecognizer(target: self, action: #selector(menuClicked(gesture:)))
//        self.menuImage.isUserInteractionEnabled = true
//        self.menuImage.addGestureRecognizer(menuTapGesture)
//
//        let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileClicked(gesture:)))
//        self.profileImage.isUserInteractionEnabled = true
//        self.profileImage.addGestureRecognizer(profileTapGesture)
        
        
        
        
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
    @objc func setTemplate(notification: NSNotification){
        self.messageText.text = notification.object as! String
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
        case 3:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "YogaViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 4:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "ThoughtOfDayViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 0 :
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "AstrologersListViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 5:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "CustomerSupportViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 2:
            let appDel = UIApplication.shared.delegate as! AppDelegate
            appDel.drawerController.setDrawerState(.closed, animated: true)
            let controller = storyboard.instantiateViewController(withIdentifier: "HowMoonSIgnWorksViewController")
            self.navigationController?.pushViewController(controller, animated: true)
            break
        case 6:
            let myURL = URL(string: "https://app.moonsign.org/MoonSignPolicy/privacypolicy.html")!
            // if openBrowser {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(myURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(myURL)
            }
            break
        case 7:
            let myURL = URL(string: "https://app.moonsign.org/MoonSignPolicy/TermsAndCondition.html")!
            // if openBrowser {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(myURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(myURL)
            }
            break
        default:
            break
        }
        
    }
    
    func fetchCustomer(){
//        Utility.ShowSVProgressHUD_White()
        if SaveData.isLoggedIn() == false{
            let stringURL:String =  HTTPConstants.baseURl + "/api/customers/CreateCustomer"
            var parameters:[String:AnyObject]?
            parameters = [
                "DeviceToken": SaveData.getDeviceToken() as AnyObject,
                "IsIos": true as AnyObject,
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
                            
                            SaveData.setWelcomeMessage(message: ["answer": (rootData.data?.conversation![0].answer?.answers!)!,"answerId":"\((rootData.data?.conversation![0].answer?.id!))","rating":"\(rootData.data?.conversation![0].answer?.rating!)","qa":"a"])
                            SaveData.setModeratorName(name: rootData.data?.conversation![0].moderator?.name ?? "MoonSign")
                            SaveData.setModeratorImageURL(url: rootData.data?.conversation![0].moderator?.imageUrl ?? "nil")
                        }
                        
                        let screenSize = UIScreen.main.bounds
                        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                        let controller = storyboard.instantiateViewController(withIdentifier: "ChatViewController")
                        self.addChildViewController(controller)
                        controller.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-70)
                        self.chatView.addSubview(controller.view)
                        controller.didMove(toParentViewController: self)
//                        Utility.DismissSVProgressHUD()
                        self.navigationItem.title = "Moonsign"
                    }
                    catch let jsonerror{
                        print(jsonerror as Any)
                    }
                    
                    
                }
            })
            
        }
    }
    

    
    @IBAction func messageBubbleClicked(_ sender: UIButton) {
         NotificationCenter.default.post(name: .messageBubbleNotification, object: nil)
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        if self.messageText.text == "" {
            
        }
        else if SaveData.isRegistered() == false{
            let ac = UIAlertController(title: "Sorry", message: "You need to register in order to send message", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            ac.addAction(UIAlertAction(title: "Register Now", style: .default, handler: { (UIAlertAction) in
                let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                let controller = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
                self.navigationController?.pushViewController(controller, animated: true)
            }))
            self.present(ac, animated: true)
        }
        else{
             NotificationCenter.default.post(name: .messageSendNotification, object: self.messageText.text)
            self.messageText.text = ""
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == self.messageText {
            if textView.text == "← Ideas what to ask"{
                textView.text = ""
                textView.textColor = UIColor.black

            }
            else if (textView.text.isEmpty){
                textView.text = "← Ideas what to ask"
                textView.textColor = UIColor.lightGray

            }
        }
    }
    
}
extension Notification.Name {
    static let navigation = Notification.Name("navigation")
    static let messageBubbleNotification = Notification.Name("messageBubble")
    static let messageSendNotification = Notification.Name("messageSend")
    static let getTemplateNotification = Notification.Name("getTemplate")
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

