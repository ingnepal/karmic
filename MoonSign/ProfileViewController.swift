//
//  ProfileViewController.swift
//  MoonSign
//
//  Created by Mac on 9/6/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit
class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var femaleCheckBox: UIImageView!
    @IBOutlet weak var maleCheckBox: UIImageView!
    @IBOutlet weak var selectGender: UIView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var timeOfBirth: UITextField!
    @IBOutlet weak var acceptTime: UIImageView!
    @IBOutlet weak var timeIsAccurate: UILabel!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var cityAndState: UITextField!
    @IBOutlet weak var acceptTnC: UIImageView!
    @IBOutlet weak var tnC: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var tobView: UIView!
    @IBOutlet weak var emailText: UITextField!
    
    
    let userDetails = UserDetailsData()
    var genderString = "Male"
    
    var isTimeAccepted: Bool = true
    var isTandCAccepted: Bool = true
    
    var imagePicker = UIImagePickerController()
    var selectedImage = UIImage()
    
    var imageBasea64 : String?
    override func viewDidLoad() {
        
        self.registerButton.backgroundColor = ColorConstants.accentColor
        
        super.viewDidLoad()
        let tncTapGesture = UITapGestureRecognizer(target: self, action: #selector(tNcClicked(gesture:)))
        let timeTapGesture = UITapGestureRecognizer(target: self, action: #selector(acceptTimeClicked(gesture:)))
        
        let tncTapGesture1 = UITapGestureRecognizer(target: self, action: #selector(tNcClicked(gesture:)))
        let timeTapGesture1 = UITapGestureRecognizer(target: self, action: #selector(acceptTimeClicked(gesture:)))
        
        let timeSelectTapGesture = UITapGestureRecognizer(target: self, action: #selector(timeOfBirthClicked(gesture:)))
        let dateSelectTapGesture = UITapGestureRecognizer(target: self, action: #selector(dateOfBirthClicked(gesture:)))
        
        let genderMaleCheckBoxTapGesture = UITapGestureRecognizer(target: self, action: #selector(maleClicked(gesture:)))
        let genderFemaleCheckBoxTapGesture = UITapGestureRecognizer(target: self, action: #selector(femaleClicked(gesture:)))
        
        let profileImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped(gesture:)))
        
        self.acceptTnC.isUserInteractionEnabled = true
        self.acceptTime.isUserInteractionEnabled = true
        self.acceptTime.image = UIImage(named: "ic_selected_yes")
        
        self.timeIsAccurate.isUserInteractionEnabled = true
        self.tnC.isUserInteractionEnabled = true
        
        self.acceptTnC.addGestureRecognizer(tncTapGesture1)
        self.tnC.addGestureRecognizer(tncTapGesture)
        self.acceptTnC.image = UIImage(named: "ic_selected_yes")
        
        self.acceptTime.addGestureRecognizer(timeTapGesture1)
        self.timeIsAccurate.addGestureRecognizer(timeTapGesture)
        
        self.dobView.isUserInteractionEnabled = true
        self.dobView.addGestureRecognizer(dateSelectTapGesture)
        
        self.tobView.isUserInteractionEnabled = true
        self.tobView.addGestureRecognizer(timeSelectTapGesture)
        
        self.maleCheckBox.isUserInteractionEnabled = true
        self.maleCheckBox.addGestureRecognizer(genderMaleCheckBoxTapGesture)
        
        self.femaleCheckBox.isUserInteractionEnabled = true
        self.femaleCheckBox.addGestureRecognizer(genderFemaleCheckBoxTapGesture)
        
        self.maleCheckBox.image = UIImage(named: "ic_selected_yes")
       
        
        self.timeOfBirth.isUserInteractionEnabled = false
        self.dateOfBirth.isUserInteractionEnabled = false
        
        
        self.navigationItem.title = "Profile"
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        Utility.ENABLE_IQKEYBOARD()
        
        self.profileImage.image = UIImage(named: "profiledefault")
        self.profileImage.isUserInteractionEnabled = true
        self.profileImage.addGestureRecognizer(profileImageTapGesture)
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.height/2
        self.profileImage.layer.masksToBounds = true
        
        if userDetails.getUserDetails()?.count ?? 0 > 0 {
            updateUI()
        }
       // getCustomerDetails()
    }
    
    fileprivate func updateUI(){
        let profile = userDetails.getUserDetails()?[0]
        self.fullName.text = profile?.fullName
        if profile?.gender == "Male" {
            femaleCheckBox.image = UIImage(named: "ic_selected_no")
            maleCheckBox.image = UIImage(named: "ic_selected_yes")
        }else{
            maleCheckBox.image = UIImage(named: "ic_selected_no")
            femaleCheckBox.image = UIImage(named: "ic_selected_yes")
        }
        var dateTime = (profile?.dateOfBirth ?? "").components(separatedBy: "T")

        self.dateOfBirth.text = dateTime[0]
        self.timeOfBirth.text = profile?.timeOfBirth
        if profile?.isTimeAccurate == true{
            acceptTime.image = UIImage(named: "ic_selected_yes")
        }
        else{
            acceptTime.image = UIImage(named: "ic_selected_no")
        }
        self.country.text = profile?.country
        self.cityAndState.text = profile?.cityAndState
        acceptTnC.image = UIImage(named: "ic_selected_yes")
        self.profileImage.af_setImage(withURL: URL(string: (profile?.photoUrl ?? "")) ?? URL(string: "user")!)
    }
    @objc func profileImageTapped(gesture:UITapGestureRecognizer){
        if (gesture.view as? UIImageView) != nil {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
                self.openCamera()
            }))
            
            alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
                self.openGallary()
            }))
            
            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
            
            //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = self.profileImage
                alert.popoverPresentationController?.sourceRect = self.profileImage.bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
            }
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //open gallery
    func openGallary(){
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        imagePicker.navigationBar.isTranslucent = false
        imagePicker.navigationItem.hidesBackButton = true
        imagePicker.navigationBar.barTintColor = ColorConstants.primaryColor // Background color
        imagePicker.navigationBar.tintColor = UIColor.white // Cancel button ~ any UITabBarButton items
        imagePicker.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white] as [NSAttributedStringKey : Any]
        
       
        imagePicker.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.white
        imagePicker.navigationBar.topItem?.rightBarButtonItem?.isEnabled = true
        //        self.present(imagePicker, animated: true, completion: nil)
        self.present(imagePicker,animated: true, completion: {
            
            self.imagePicker.navigationController?.navigationBar.tintAdjustmentMode = .normal
            self.imagePicker.navigationController?.navigationBar.tintAdjustmentMode = .automatic
            //            let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(self.closePicker))
            //           self.imagePicker.navigationItem.rightBarButtonItem = button
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @objc func timeOfBirthClicked(gesture: UITapGestureRecognizer){
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "DateTimePickerViewController") as! DateTimePickerViewController
        controller.isTimeOnlyflag = true
        controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
        
       
    }
    @objc func dateOfBirthClicked(gesture: UITapGestureRecognizer){
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "DateTimePickerViewController") as! DateTimePickerViewController
        controller.isTimeOnlyflag = false
        controller.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func registerClicked(_ sender: UIButton) {
        if self.fullName.text == ""{
            let ac = UIAlertController(title: "Sorry", message: "Please fill all the fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            return
        }
//        if self.gender.text == ""{
//            let ac = UIAlertController(title: "Sorry", message: "Please fill all the fields", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "OK", style: .default))
//            self.present(ac, animated: true)
//            return
//
//        }
        if self.cityAndState.text == ""{
            let ac = UIAlertController(title: "Sorry", message: "Please fill all the fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            return
        }
        if self.timeOfBirth.text == ""{
            let ac = UIAlertController(title: "Sorry", message: "Please fill all the fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            return
        }
        if self.country.text == ""{
            let ac = UIAlertController(title: "Sorry", message: "Please fill all the fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            return
        }
        if self.cityAndState.text == ""{
            let ac = UIAlertController(title: "Sorry", message: "Please fill all the fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            return
        }
        if isTimeAccepted == false{
            let ac = UIAlertController(title: "Sorry", message: "Please fill all the fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            return
        }
        if isTandCAccepted == false{
            let ac = UIAlertController(title: "Sorry", message: "Please fill all the fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            return
        }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        if dateFormatterGet.date(from: "\(self.dateOfBirth.text!) \(self.timeOfBirth.text!)") == nil {
            let ac = UIAlertController(title: "Sorry", message: "Invalid Date and Time of Birth", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            return
        }
        
        storeUploadUserData()
        
    }
    
    @objc func maleClicked(gesture: UITapGestureRecognizer){
        if self.genderString == "Male" {
            maleCheckBox.image = UIImage(named: "ic_selected_no")
            femaleCheckBox.image = UIImage(named: "ic_selected_yes")
            genderString = "Female"
        }
        else{
            maleCheckBox.image = UIImage(named: "ic_selected_yes")
            femaleCheckBox.image = UIImage(named: "ic_selected_no")
            genderString = "Male"
        }
    }
    @objc func femaleClicked(gesture: UITapGestureRecognizer){
        if self.genderString == "Male" {
            maleCheckBox.image = UIImage(named: "ic_selected_no")
            femaleCheckBox.image = UIImage(named: "ic_selected_yes")
            genderString = "Female"
        }
        else{
            maleCheckBox.image = UIImage(named: "ic_selected_yes")
            femaleCheckBox.image = UIImage(named: "ic_selected_no")
            genderString = "Male"
        }
    }
    
    @objc func tNcClicked(gesture: UITapGestureRecognizer){
        if isTandCAccepted == false{
            isTandCAccepted = true
            acceptTnC.image = UIImage(named: "ic_selected_yes")
        }
        else{
            isTandCAccepted = false
            acceptTnC.image = UIImage(named: "ic_selected_no")
        }
        
    }
    
    @objc func acceptTimeClicked(gesture: UITapGestureRecognizer){
        if isTimeAccepted == false{
            isTimeAccepted = true
            acceptTime.image = UIImage(named: "ic_selected_yes")
        }
        else{
            isTimeAccepted = false
            acceptTime.image = UIImage(named: "ic_selected_no")
        }
    }
    
    func getCustomerDetails(){
        let stringURL = HTTPConstants.baseURl + "api/customers/GetCustomer/" + SaveData.getCustomerID()
        HTTPRequests.HTTPGetRequestData(stringURL) { (response, statusFlag) in
            if statusFlag{
                do{
                    let root = try JSONDecoder().decode(GetCustomerDetailsRoot.self, from: response!)
                    if root.meta?.status! ?? false == true{
                        self.fullName.text = root.data?.profileName ?? ""
                        self.genderString = root.data?.gender ?? ""
//                        self.dateOfBirth.text = root.data?.dOB ?? ""
                        self.country.text = root.data?.country ?? ""
                        self.cityAndState.text = root.data?.cityRegion ?? ""
                        self.profileImage.af_setImage(withURL: URL(string: (root.data?.imageUrl ?? "")) ?? URL(string: "user")!)
                        let delimiter = "T"
                        var dateTime = (root.data?.dOB ?? "").components(separatedBy: delimiter)
                        print(dateTime[0])
                        self.dateOfBirth.text = dateTime[0]
                        self.timeOfBirth.text = dateTime[1]
                        SaveData.setProfileImageURL(url: root.data?.imageUrl ?? "")
                    }
                }
                catch let jsonerror{
                    print(jsonerror)
                }
            }
        }
    }
    
    func storeUploadUserData(){
        Utility.ShowSVProgressHUD_Black_With_IgnoringInteraction()
        let stringURL = HTTPConstants.baseURl + "api/customers/UpdateCustomer"
        var parameters:[String:AnyObject]?
        parameters = [
            "Id": SaveData.getCustomerID() as AnyObject,
            "ProfileName": self.fullName.text! as AnyObject,
            "RightName": self.fullName.text! as AnyObject,
            "Gender": self.genderString as AnyObject,
            "DOB": self.dateOfBirth.text! as AnyObject,
            "CityRegion": self.cityAndState.text! as AnyObject,
            "Country": self.country.text! as AnyObject,
            "DeviceToken": "sdsajdsji12" as AnyObject,
            "MacAddress": UIDevice.current.identifierForVendor?.uuidString as AnyObject,
            "ImageUrl": imageBasea64 as AnyObject,
            "Email": (self.emailText.text ?? "") as AnyObject
            ] as [String : AnyObject]
        print(parameters as AnyObject)
        HTTPRequests.HTTPPutRequestData(stringURL, parameters: parameters!, withSuccess: {(response,statusFlag) in
            if statusFlag{
                do{
                    Utility.DismissSVProgressHUD_With_endIgnoringInteraction()
                    let rootData = try JSONDecoder().decode(UpdateCustomerRoot.self, from: response!)
                    
                    if rootData.meta?.status! ?? false == true{
                        self.fullName.text = rootData.data?.profileName
                        self.genderString = rootData.data?.gender ?? "Male"
                        self.dateOfBirth.text = rootData.data?.dOB
                        self.cityAndState.text = rootData.data?.cityRegion
                        self.country.text = rootData.data?.country
                        self.userDetails.saveUserData(cityAndState: self.cityAndState.text!, country: self.country.text!, dob: self.dateOfBirth.text!, fullName: self.fullName.text!, gender: self.genderString, isTermsAgreed: self.isTandCAccepted, isTimeAccurate: self.isTimeAccepted, photoUrl: (rootData.data?.imageUrl) ?? "", timeOfBirth: self.timeOfBirth.text!)
                        
                        SaveData.setRegisteredStatus(flag: true)
                        
                        
                        let ac = UIAlertController(title: "Success", message: "Your details has been updated succesfully", preferredStyle: .alert)
                        
                        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                            self.navigationController?.popViewController(animated: true)

                        }))
                        self.present(ac, animated: true)
                        
                        
                    }
                    
                }
                catch let jsonerror{
                    print(jsonerror)
                }
            }
            else{
                 Utility.DismissSVProgressHUD_With_endIgnoringInteraction()
                let ac = UIAlertController(title: "Sorry", message: "Please check your internet connection", preferredStyle: .alert)
                
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                    
                }))
                self.present(ac, animated: true)
            }
            
        })
    }
}
extension ProfileViewController: DateTimeSelectDelegate{
    func getDateTime(dateTime: String, isTimeOnly: Bool) {
        if isTimeOnly{
            self.timeOfBirth.text = dateTime
        }
        else{
            self.dateOfBirth.text = dateTime
        }
    }
}
extension ProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        /*
         Get the image from the info dictionary.
         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
         instead of `UIImagePickerControllerEditedImage`
         */
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            let imgData: NSData = NSData(data: UIImageJPEGRepresentation((editedImage), 1)!)
            let imageSize: Int = imgData.length
            print("size of image in KB: %f ", Double(imageSize) / 1024.0)
            if (Double(imageSize) / 1024.0 < 2048){
                
                let strBase64 = imgData.base64EncodedString(options: .lineLength64Characters)
                self.imageBasea64 = strBase64
                
                self.profileImage.image = editedImage
            }
            else{
//                RMessageHelper.showNotificationTypeError(self, title: "Sorry!", subtitle: "Please select image below 2MB")
            }
        }
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: { () -> Void in
            
        })
        print("Cancelled")
    }
    
}
