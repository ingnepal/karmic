//
//  ProfileViewController.swift
//  MoonSign
//
//  Created by Mac on 9/6/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import UIKit
class ProfileViewController: UIViewController {

    @IBOutlet weak var selectGender: UIView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var gender: UITextField!
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
    
    var isTimeAccepted: Bool = false
    var isTandCAccepted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tncTapGesture = UITapGestureRecognizer(target: self, action: #selector(tNcClicked(gesture:)))
        let timeTapGesture = UITapGestureRecognizer(target: self, action: #selector(acceptTimeClicked(gesture:)))
        
        let timeSelectTapGesture = UITapGestureRecognizer(target: self, action: #selector(timeOfBirthClicked(gesture:)))
        let dateSelectTapGesture = UITapGestureRecognizer(target: self, action: #selector(dateOfBirthClicked(gesture:)))
        
        self.acceptTnC.isUserInteractionEnabled = true
        self.acceptTime.isUserInteractionEnabled = true
        self.acceptTime.image = UIImage(named: "ic_selected_no")
        
        self.timeIsAccurate.isUserInteractionEnabled = true
        self.tnC.isUserInteractionEnabled = true
        
        self.acceptTnC.addGestureRecognizer(tncTapGesture)
        self.tnC.addGestureRecognizer(tncTapGesture)
        self.acceptTnC.image = UIImage(named: "ic_selected_no")
        
        self.acceptTime.addGestureRecognizer(timeTapGesture)
        self.timeIsAccurate.addGestureRecognizer(timeTapGesture)
        
        self.dobView.isUserInteractionEnabled = true
        self.dobView.addGestureRecognizer(dateSelectTapGesture)
        
        self.tobView.isUserInteractionEnabled = true
        self.tobView.addGestureRecognizer(timeSelectTapGesture)
        
        self.timeOfBirth.isUserInteractionEnabled = false
        self.dateOfBirth.isUserInteractionEnabled = false
        
        
        self.navigationItem.title = "Profile"
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        Utility.ENABLE_IQKEYBOARD()
        
        self.gender.isUserInteractionEnabled = false
        
        let genderTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectGenderTap(gesture:)))
        self.selectGender.isUserInteractionEnabled = true
        self.selectGender.addGestureRecognizer(genderTapGesture)
        
        getCustomerDetails()
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
    
    @objc func selectGenderTap(gesture: UITapGestureRecognizer){
        let alert = UIAlertController(title: "Select Gender", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Male", style: .default, handler: { _ in
            self.gender.text = "Male"
        }))
        
        alert.addAction(UIAlertAction(title: "Female", style: .default, handler: { _ in
           self.gender.text = "Female"
        }))
        
        alert.addAction(UIAlertAction(title: "Others", style: .default, handler: { _ in
            self.gender.text = "Others"
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = self.selectGender
            alert.popoverPresentationController?.sourceRect = self.selectGender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func registerClicked(_ sender: UIButton) {
        if self.fullName.text == ""{
            let ac = UIAlertController(title: "Sorry", message: "Please fill all the fields", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
            return
        }
        if self.gender.text == ""{
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
                        self.gender.text = root.data?.gender ?? ""
                        self.dateOfBirth.text = root.data?.dOB ?? ""
                        self.country.text = root.data?.country ?? ""
                        self.cityAndState.text = root.data?.cityRegion ?? ""
                    }
                }
                catch let jsonerror{
                    print(jsonerror)
                }
            }
        }
    }
    
    func storeUploadUserData(){
        
        let stringURL = HTTPConstants.baseURl + "api/customers/UpdateCustomer"
        var parameters:[String:AnyObject]?
        parameters = [
            "Id": SaveData.getCustomerID() as AnyObject,
            "ProfileName": self.fullName.text! as AnyObject,
            "RightName": self.fullName.text! as AnyObject,
            "Gender": self.gender.text! as AnyObject,
            "DOB": self.dateOfBirth.text! as AnyObject,
            "CityRegion": self.cityAndState.text! as AnyObject,
            "Country": self.country.text! as AnyObject,
            "DeviceToken": "sdsajdsji12" as AnyObject,
            "MacAddress": UIDevice.current.identifierForVendor?.uuidString as AnyObject,
            "ImageUrl": "/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMHBhUTEhMWFRUWFxkZGBYYFRsVExYZHRgbFx0YGB0ZHSggGBsmHhcXIz0hJSkrLi46Gh8zODMtNygtLisBCgoKDg0OGhAQGy0lHyUtLTMvMi0tNS4tNjUtLTUuLS0tMC0tNS8tLSs1LS0vLS0tLS0tLS8tLy0tLS03Ny0tLf/AABEIAOUA3AMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAABgcDBAUIAgH/xABCEAACAQIDBQQFCAkDBQAAAAAAAQIDEQQFIQYSMUFRImFxgQcTFJGxIzJCUoKhwdEVFmJykqKz4fAIJDM2Q1N0k//EABkBAQADAQEAAAAAAAAAAAAAAAACAwQFAf/EACYRAQACAgICAgIBBQAAAAAAAAABAgMREiEEMRNBMmFxIlFSwfD/2gAMAwEAAhEDEQA/AKNAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADp5Hk8s2qvXdjHjK1/BLvObGLlKyV2+C5ssvJ8tWWZbGGm9xk/2nx/LyKc2ThHXtZjpylDs32cnl9LfjJTguLSs14rocQtdwvCz4e++hCtqsnWFl66DW7J6x6N34dV3ciGHNy6slkx67hHQAaVIAAAAAAAAAAAAAAAAAAAAAAAAAAAB+xW87ICR7E5Z7XmHrJLs0+HfLl7uPuJ3KNjXyHK1lmVQg12uM++T4+7h5G61df3Obmvys1466hruFkQPbWqp5qoq/Yik9dLt3+DRP6nYg2+CV35FT43EPFYuc39KTfvZb41d22jmnrTAADazAAAAAAAAAAAAAAAAAAAAAAAAAAAEj2Gy323Nt9rs0u13OX0V+PkRwt7ZrJHk+TwhJWnK059VKSWj8FZFGe/Gv8p467luuOpjlHs8dTO1qfMo3RzmpwdrsV7LkM+suwu+/H7rlYk19I2I3Z0qV+s2v5V8JEKOj49dU/lmyzuwAC9WAAAAAAAAAAAAAAAAAAAAAAAAAACbeiPZr9YtrobyvSofK1Ojs+xHzlbTopF+ZxknrotrX7l0Tf+cl0ON6HNmv1f2QjOcbVsTarPTVRt8nB6X0i72fBzkTqUd5HG8rNyydeoW16VXj8C6EuFl4p/f1t+JoSWhZ+ZZYsTHv68/y5vR9WQvNspeGbdtOL66LXTr/AHIVvtdFlH7ZYn2naGp0jaC8lr99ziGXFVfaMTKb+lJv3u5iO1WNREMszudgAJPAAAAAAAAAAAAAAAAAAAAAAAAAlPo12c/Wfa2lSkr04v1lXpuRabX2naPmRY9F+gzZv9EbMPEzVqmKakuqpK6gvO7l4OPQo8jL8dJn7e1jcrIRobQZl+h8krV93f8AVwlJRvbel9GN+V3ZeZ0ClvTxtdKhi6eCoTturfrNPnJNQg+9J7+vBuDVmkzkYMU5LxCyZ0uWhP1tGLdtUno7rhyfNd5yNrmsLs5iKv8A46NSS0XKDa+853oq3l6PcJvNt7j1bbdt+VlrySsfHpaxXsno8xT+tGMP4pxj8GIprLx/f+zfTy0ADvKgAy4bDTxVTdhGUn0im39wGIHejshi5NfJpXV778bLuevE+4bNwp1lGriqUZO/Zheo9E272tZ2TIfJX+6XGUeB36kMBhJNXr1ZJPkoRuuTvaSMVPN6NGd44SnbSyk3N8Hq214DlM+oNftxTLTw06j7MJPwi2dGrtBWlJbm5TS5Qgl7+ppyzGtOV3Vn/G/zPe3nTPDI8RNf8Ul42j8WfMsqnBXbpqztrUjx424mpKtKV7ybvx1evj1MY7Om5LAernaVSnHr2t638Nz5r0KcJ2jV3l13JL4mqD3QAA9eAAAAAAAAO7sRkEtptpqOHV92Ur1Gvo046yfdpp4tHrSjSjQpKMUoxikklwSSskvIqv0BbNew5NPGzj26/Zp34qlF6v7Ul/Ii1zj+bl5X1HqFlY6cjazPIbN7PVsTP/tx7MfrTekY+cmvvZ5KzDGzzHHTq1ZOU6knKUnzbd2Wn6f9pfa80p4Gm+zR7dXo6sl2V9mDf/0fQqVK7Nnh4uNOU+5RtPb1xsTh/ZNjsHB8sPSv4uCb+JGfTpPd9H011q0l97f4E8wlP1OEhFcIxivckhXw0MTu78Yy3ZKUd5J2kk0pK/PV6nNjJxycv2nrp5LybZHHZ3b2fC1Zp8J7u7Tf25Wj95Pcl9B2Kr1/91Xp0oK3/HerN9bXsl43fgXTtBn1DZ3LnWxNRQgrLg223wSUU2/cVHtF6bZVcC4YWilOSlepPVQTlolH6T3OLel3w012xnz5fwjUI6iHZxmwOTbL4dSr1I3txr1U5PnpBWT0/ZZE832vwOW1lDDfKR1v6uG5Dg7W3rX1tyKvnNzervol5JWS92h8miPH/wA7TJF5j0kedbVSzGLUae7Fpp3nKejafDSK+auXU4FWvKt86TfwXh0MYL61isahGZ2AAk8AAAAAAAAAAAAAAAADqbMZLPaHP6OGhxqTSb+rHjKXlFN+Ryy8/wDT/s16nB1MfNa1L0qX7ifbl5ySj9h9SrNk+Ok2exG1tYLCQwGDhSprdhTioRj0jFWS9yOVtjtHDZjI51pJyl82lBJt1Kj+bH8X3J9DuGpmeF9rwjjv+rdn8puxlKGjTcd9OKdm9WmtXocOsxy3Za8x5TlCzrO9/HVam9Wk5uNOMZVpzldqGrtCUnrqmoppuyaLt2c9GeCyLFwrpNyhGLUnJ23ot2qXvdNptNK0H0NHaHaXKdkcPDEUqcMTiKiSp7slUrSjFOEZyqTbkqfY3VJXvyTXCqs89JWNznGP185RpqTapUJ+pS5Wc4pynHz8Gjpz8mb8f6YQ6h6d5EH9Ku2z2PyqCpxvWr7yg382CileT66yjpzu9USjZ/Fyx+Q4erNWlUo05tK9k5QUna7b582U5/qMk3mWEXL1dRrx3o3+CMXj44tmitv+0lM9KpzXMambZhOtVk5TnJt3lKVru+6nNuVlwV2zUAO2qAAAAAAAAAAAAAAAAAAAAAAA2MFgp46tuwV+bfCMVzcnwSG9D6yvBSzHMIUo8Zyt4Lm33JXfkeptl8VTwuW0qFNWjTgoxWt7JWv0bdm/eUnsNlEMNSddvek96MJcI7t7NpcdWuevcTfC4l0LWf5fdzOb5duc8Y+l9KdbWXmecUMpwPra9WNKnot6bsm3wS5t8dF0Z569I/pLrbTYidGg5U8KnZJXUqv7VTuf1OGut3wz+kHarD5riEnKVbchJKmrqjGq04qpKV7z3VJtKPFrV20K4buWeL40V/qt7V2n6L6n4AbkHsHZj/prC/8Ar0f6cSov9RySxeCd3fdraclrDVd719yLY2Ore0bJYSXXDUf6cThbd7Myz7aHL5qCnCnKuqikrwSlS3oufc5QS8zi4bRTNufra2fTzADNi6DwuKnTlxhJxfinZ/AwnaVAAAAAAAAAAAAAAAAAAAAG7lWWzzPFqEPFvlFdX+R5MxEbkiNvzK8vlmWI3U4xSW9KUnaMY3SbfvJPRdOhGNCm2oztuqK+VrPhvyf0IcbO17JtW0Zhz+nDJsJGjHg1e19asr/OqW+grcObfcbexOBdWpLE1XvSldRvq11f4dyKL33Xl9fS2tdTpMMJQjhqKhFJRirJLlb4+ZobTZisryictN6S3Yr9p/krvyMtWu3joU4p63nJrXdilpf96Vl3pMrvanOJZrmL+pBtQS4cfnPvdvgZsWKbW3Ky9tQ4oAOizAAA9Q+h/H/pD0fYfrTUqT7t2Tt/K4kzPIeze02K2ZxnrMNVcH9KPGnNdJxej+K5NF77J+l3BZvhP9zJYWsvnRld0pa2vCVu/g9V3pXOV5Pi2iZtXuJWVsofbCn6ra3Frpia39SRyDs7ZYynmG1mKq0nenOtUlF9U5N38DjHTp+MK5AASAAAAAAAAAAAAAAAAGbCYaWMxChBXk3p/fuLFyjLo5XgdyOr4ylw3n+COdszlv6Owm+18pNa9Yx+r8DcznFOnhN2Os6j3YxXNv8ABc+Rjy3m9uMemmlOMblE8fTlnGf7sG5NtJy5W5yXSCXDuS5sn+GoxwOEUFZQhHn0tdt/E4+z2DVCm5aPVpz51JX7Uv3U9F4N8zazGXr6saP1u1U7qaeqf7z7PvI5Lcpiseoe0jUbaeaZm8Dk06t7VK77CfGMbWjp3Re94yIAdTaLMP0jmcmneMezDpZc/Pics1YqcYUXtuQAFiAAAAAAAAAAAAAAAAAAAAAAAAAdjZnA+14/el82Gvi+S/HyOOTbZ3C+z5XHrPt+/h91irNbjVZiruzsb1kaWIoTxGIlbR23FK+sIPWUo/tSen2Tab3Xx/NfmfcH8DDE67a5jb7ju4XDW0jGMf4UvwsR/NcY8JlU5vs1MQ9E+MYLgu57rv4yZ0sWvaasafL50+m7fSL8WvcmQ/aDMf0jmDa+ZHsx8Fz83+BdhpuVOS2ocwAG1mAAAAAAAAAAAAAAAAAAAAAAAAAAA4lg0oOlTSWqVtF3eBX8dJE5wuLhi4XjJNc1rdeXuM3kb1C/B7luqWjv/c/d+0Nb9e/+5h1/z3n7UqqlScnwjq/BfiZWlyc/xvsmA3b/AClXV90eFvdaPkyJGzmGLeNxbm+fBdFyRrHQx14wxXtuQAE0AAAAAAAAAAAAAAAAAAAAAAAAAAAD6hN053Taa5p2Z8gDvZbtC6WlRXX1l87zXP8AzifWf5rGvQ3KbvezbS5cbe+xHwV/FXlyT+S2tAALEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf//Z" as AnyObject
            ] as [String : AnyObject]
        print(parameters as AnyObject)
        HTTPRequests.HTTPPutRequestData(stringURL, parameters: parameters!, withSuccess: {(response,statusFlag) in
            if statusFlag{
                do{
                    let rootData = try JSONDecoder().decode(UpdateCustomerRoot.self, from: response!)
                    
                    if rootData.meta?.status! ?? false == true{
                        self.fullName.text = rootData.data?.profileName
                        self.gender.text = rootData.data?.gender
                        self.dateOfBirth.text = rootData.data?.dOB
                        self.cityAndState.text = rootData.data?.cityRegion
                        self.country.text = rootData.data?.country
                        
                        
                        self.navigationController?.popViewController(animated: true)
                        
                        let ac = UIAlertController(title: "Success", message: "Your details has been updated succesfully", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                        
                        
                    }
                    
                }
                catch let jsonerror{
                    print(jsonerror)
                }
            }
            else{
                
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
