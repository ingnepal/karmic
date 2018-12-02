//
//  WelcomeViewController.swift
//  Prabhu Pay
//
//  Created by Mac on 7/29/18.
//  Copyright © 2018 Qpay. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
//    let walkThroughDescription = ["Welcome to Prabhu Pay. \n      ...वालेट अब मोबाइलमा","Easily load fund in your prabhu pay wallet using Card, E-banking. Merchant top-up and through Connect IPS.","Recharge Mobile, Pay Bills, Buy Tickets, Book Hotels and many more.","You can withdraw cash from your prabhu pay wallet via nearby prabhu money transfer agents."]
    
    let walkThroughDescription = ["Welcome to Prabhu Pay. \n      ...वालेट अब मोबाइलमा","Recharge Mobile, Pay Bills, Buy Tickets, Book Hotels and many more.","Regular Users will qualify for accidental insurance worth Rupees\n10 LAKHS \n*Conditions Apply"]
    
    let walkThroughTitle = ["Welcome", "Easy Payment", "Exclusive Offer"]
  //  toName.pushTop(0.2)

    
    @IBOutlet weak var container3: UIView!
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var imgDescription: UIImageView!
    @IBOutlet weak var viewButtonContainer: UIView!
    @IBOutlet var viewContainer: UIView!
    var currentPage = 0
    override func viewDidLoad() {
        super.viewDidLoad()

//        viewContainer.backgroundColor = ColorConstants.primaryColor
//        viewButtonContainer.backgroundColor = ColorConstants.primaryColor
        pageControl.numberOfPages = 3
        btnLeft.isHidden = true
        self.container1.isHidden = false
        self.container2.isHidden = true
        self.container3.isHidden = true
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.viewContainer.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.viewContainer.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.viewContainer.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.viewContainer.addGestureRecognizer(swipeDown)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func switchPage(){
        switch self.currentPage{
        case 0:
            self.container1.isHidden = false
            self.container2.isHidden = true
            self.container3.isHidden = true
            break
        case 1:
            self.container1.isHidden = true
            self.container2.isHidden = false
            self.container3.isHidden = true
            break
        case 2:
            self.container1.isHidden = true
            self.container2.isHidden = true
            self.container3.isHidden = false
            break
        default:
            break
        }
    }
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            if currentPage == 0{
                print("skipped")
                
            }else{
                currentPage -= 1
                if currentPage == 0{
                    btnLeft.isHidden = true
                }
                pageControl.currentPage = currentPage
                
                imgDescription.pushRight(0.2)
                
                
                imgDescription.image = UIImage(named: "ic_main_with_sign")
               switchPage()
                
            }
            
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            if currentPage == 2{
//                print("next")
//                let vc = storyboardRegistration.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                self.navigationController?.pushViewController(vc, animated: true)
                AppDelegate.globalDelegate()?.openDashboard()
            }else{
                btnLeft.isHidden = false
                currentPage += 1
                pageControl.currentPage = currentPage
                imgDescription.pushLeft(0.2)
                
                imgDescription.image = UIImage(named: "ic_main_with_sign")
               switchPage()
                
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.up {
            print("Swipe Up")
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.down {
            print("Swipe Down")
        }
    }
    @IBAction func onRightPressed(_ sender: UIButton) {
        if currentPage == 2{
            print("next")
            AppDelegate.globalDelegate()?.openDashboard()
        }else{
            btnLeft.isHidden = false
            currentPage += 1
            pageControl.currentPage = currentPage
            imgDescription.pushLeft(0.2)
            
            imgDescription.image = UIImage(named: "ic_main_with_sign")
            switchPage()

        }
    }
    
    @IBAction func onLeftPressed(_ sender: UIButton) {
        if currentPage == 0{
            print("skipped")

        }else{
            currentPage -= 1
            if currentPage == 0{
                btnLeft.isHidden = true
            }
            pageControl.currentPage = currentPage
            
            imgDescription.pushRight(0.2)
           
            
            imgDescription.image = UIImage(named: "ic_main_with_sign")
            switchPage()

        }

    }
    
}
extension UIView{
    func pushLeft(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromRight
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionPush)
    }
    
    func pushRight(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromLeft
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionPush)
    }
}
