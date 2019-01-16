//
//  Utility.swift
//  QPayMerchant
//
//  Created by QPay on 8/4/16.
//  Copyright © 2016 qpaysolutions. All rights reserved.
//

import Foundation
import SVProgressHUD
import UIKit
import IQKeyboardManagerSwift
var model: String {
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            print("iPhone 5 or 5S or 5C")
            
        case 1334:
            print("iPhone 6/6S/7/8")
            
        case 1920, 2208:
            print("iPhone 6+/6S+/7+/8+")
            
        case 2436:
            return "iPhone X"
            
        case 2688:
            return "iPhone X"
            
        case 1792:
            return "iPhone X"
            
        default:
            print("Unknown")
        }
    }
    return "Unknown"
}
var modelName: String {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    switch identifier {
    case "iPod5,1":                                 return "iPod Touch 5"
    case "iPod7,1":                                 return "iPod Touch 6"
    case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
    case "iPhone4,1":                               return "iPhone 4s"
    case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
    case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
    case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
    case "iPhone7,2":                               return "iPhone 6"
    case "iPhone7,1":                               return "iPhone 6 Plus"
    case "iPhone8,1":                               return "iPhone 6s"
    case "iPhone8,2":                               return "iPhone 6s Plus"
    case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
    case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
    case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
    case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
    case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
    case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
    case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
    case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
    case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
    case "iPad6,7", "iPad6,8":                      return "iPad Pro"
    case "AppleTV5,3":                              return "Apple TV"
    case "i386", "x86_64":                          return "Simulator"
    default:                                        return identifier
    }
}

class Utility{
    
    
    
    // MARK: - UTILITY
    
    
    /**
     Creates a request using regardin card .
     
     
     
     -     class func ShowSVProgressHUD_White() ;
     
     
     -     class func ShowSVProgressHUD_Black() ;
     
     
     -     class func ShowSVProgressHUD_White_With_IgnoringInteraction() ;
     
     
     -     class func ShowSVProgressHUD_Black_With_IgnoringInteraction()  ;
     
     
     -      class func DismissSVProgressHUD() ;
     
     
     -     class func DismissSVProgressHUD_With_endIgnoringInteraction() ;
     
     
     -     class func BEGIN_IGNORING_INTERACTIONS() ;
     
     
     -     class func END_IGNORING_INTERACTIONS() ;
     
     
     -     class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat  ;
     
     
     -     class func makeCall(controller: UIViewController,phone: String) ;
     
     
     -     class func getImageWithColor(color: UIColor, size: CGSize) -> UIImage ;
     
     
     -     class func addTextToImage(text: NSString, inImage: UIImage, atPoint:CGPoint)-> UIImage;
     
     
     -     class func getFirstLetter(text: String)-> String ;
     
     
     -     class func isValidNcellNTCMobile(strBillpaycode: String)-> Bool{
     
     
     -     class func isValidNTCLandLine(strBillpaycode: String)-> Bool{
     
     -     class func isBillpaycode(strBillpaycode: String)-> Bool{
     
     
     */
    
    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        
        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.value(forHTTPHeaderField: "Content-Length")
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl.path, error)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
   class func isValidPhoneNum(_ phoneTxt:String) -> Bool     {
        let emailRegEx = "^(?!\\s*$).+"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: phoneTxt)
    }
//    class func getDevToken()->String{
//        return SaveData.getDeviceToken()
//    }
    
    // MARK: - SV PROGRESS HUD
    
    class func ShowSVProgressHUD_White() {
        // UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        SVProgressHUD.show()
        /*
         Utility.ShowSVProgressHUD_White()
         */
        
    }

  
//    class func getLatitude()->Double {
//        return SaveData.getLatitude()
//    }
//    
//    class func getLongitude()->Double {
//        return SaveData.getLongitude()
//    }
    
    
    class func ShowSVProgressHUD_Black() {
        // UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        SVProgressHUD.show()
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setBackgroundColor( UIColor.black.withAlphaComponent(0.4))
        SVProgressHUD.setForegroundColor( UIColor.white)
        SVProgressHUD.setRingThickness( 1.0)
        /*
         Utility.ShowSVProgressHUD_Black()
         */
        
    }
    
    
    
    class func ShowSVProgressHUD_White_With_IgnoringInteraction() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        SVProgressHUD.show()
        /*
         Utility.ShowSVProgressHUD_White()
         */
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setBackgroundColor( UIColor.white.withAlphaComponent(0.8))
        SVProgressHUD.setForegroundColor( UIColor.black)
        SVProgressHUD.setRingThickness( 1.0)

        
    }
    
    class func prepareMessage(messsage: String)-> String {
        return messsage.replacingOccurrences(of: "QPay", with: "Prabhu Pay", options: .literal, range: nil)
    }
    
    
    class func ShowSVProgressHUD_Black_With_IgnoringInteraction() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        SVProgressHUD.show()
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom)
        SVProgressHUD.setBackgroundColor( UIColor.black.withAlphaComponent(0.4))
        SVProgressHUD.setForegroundColor( UIColor.white)
        SVProgressHUD.setRingThickness( 1.0)
        /*
         Utility.ShowSVProgressHUD_Black()
         */
        
    }
    
    
    
    class func DismissSVProgressHUD() {
        //  UIApplication.sharedApplication().endIgnoringInteractionEvents()
        
        SVProgressHUD.dismiss()
        /*
         Utility.DismissSVProgressHUD()
         */
        
        
    }
    
    class func DismissSVProgressHUD_With_endIgnoringInteraction() {
        UIApplication.shared.endIgnoringInteractionEvents()
        SVProgressHUD.dismiss()
        /*
         Utility.DismissSVProgressHUD()
         */
        
        
    }

    
    // MARK: - BEGIN IGNORING INTERACTIONS
    
    class func BEGIN_IGNORING_INTERACTIONS() {
        UIApplication.shared.beginIgnoringInteractionEvents()
        
    }
    
    class func createLocalUrl(forImageNamed name: String) -> URL? {
        
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        
        guard fileManager.fileExists(atPath: url.path) else {
            guard
                let image = UIImage(named: name),
                let data = UIImagePNGRepresentation(image)
                else { return nil }
            
            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }
        
        return url
    }
    
    class func END_IGNORING_INTERACTIONS() {
        UIApplication.shared.endIgnoringInteractionEvents()
        
        
        
    }
    // MARK: - IQKeyboardManagerSwift
    
    class func ENABLE_IQKEYBOARD() {
        IQKeyboardManager.shared.enable = true
        
    }
    
    class func DISABLE_IQKEYBOARD() {
        IQKeyboardManager.shared.enable = false
        
    }
    
    
    class func ENABLE_IQKEYBOARD_AUTO_TOOLBAR() {
        IQKeyboardManager.shared.enableAutoToolbar = true
        
    }
    
    class func DISABLE_IQKEYBOARD_AUTO_TOOLBAR() {
        IQKeyboardManager.shared.enableAutoToolbar = false
        
    }
    
    // MARK: - IQKeyboardManagerSwift
    
    class func IQKEYBOARD_SOLVE_NAVIGATION_BAR_GOES_UP_ISSUE ()-> UIScrollView {
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        return scrollView
    }
    
    class func isValidEmail(_ emailTxt:String) -> Bool     {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailCheck.evaluate(with: emailTxt)
    }
    
    class func askForLocationPermission(_ controller: UIViewController) {
        
        let alert = UIAlertController(title: "Location Access Disabled", message: "Turn on your location setting in Prabhu Pay", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
            let url = URL(string: UIApplicationOpenSettingsURLString)!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
                
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        controller.present(alert, animated: true, completion: nil)
        
    }
}
    

//    class func convertDateFormater(_ strDate: String) -> String {
//        /*
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
// */
//        
//        let dateFormatter = DateFormatter()
//        // Set the locale first ...
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        // ... and then the date format:
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        
//        guard let date = dateFormatter.date(from: strDate) else {
//            //  assert(false, "no date from string")
//            print("no date found")
//            print(strDate)
//            return strDate
//
//        }
//
//        dateFormatter.dateFormat = "MMM dd yyyy" //"yyyy MMM"
//        let timeStamp = dateFormatter.string(from: date)
//
//       // print(timeStamp)
//        return timeStamp
//    }
//
//
//    
//    class func convertDateAndTimefromDate(_ strDate: String) -> String {
//
//        let dateFormatter = DateFormatter()
//        // Set the locale first ...
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        // ... and then the date format:
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        guard let date = dateFormatter.date(from: strDate) else {
//          //  assert(false, "no date from string")
//            print("no date found")
//            print(strDate)
//            return strDate
//
//        }
//        
//        dateFormatter.dateFormat = "MMM dd yyyy hh:mm a" //"yyyy MMM"
//       // dateFormatter.timeZone = TimeZone(identifier: "UTC")
//        let timeStamp = dateFormatter.string(from: date)
//        
//        // print(timeStamp)
//        return timeStamp
//    }
//    class func convertTimefromDate (_ strDate: String) -> String {
//        /*
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss "
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
// */
//
//        let dateFormatter = DateFormatter()
//        // Set the locale first ...
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        // ... and then the date format:
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//        
//        guard let date = dateFormatter.date(from: strDate) else {
//           // assert(false, "no date from string")
//            print("no date found")
//            print(strDate)
//            return strDate
//        }
//
//        dateFormatter.dateFormat = "hh:mm a"
//        let timeStamp = dateFormatter.string(from: date)
//
//        print(timeStamp)
//        return timeStamp
//    }
//
//
//
//
//    class func heightForView(_ text:String, font:UIFont, width:CGFloat) -> CGFloat{
//
//        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//
//        label.sizeToFit()
//        return label.frame.height
//    }
//
//    
//    class func makeCall(_ controller: UIViewController,phone: String) {
//        
//        if(isIPhone()){
//            let formatedNumber = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
//            let phoneUrl = "tel://\(formatedNumber)"
//            let url:URL = URL(string: phoneUrl)!
//            UIApplication.shared.openURL(url)
//
//        }else{
//              RMessageHelper.showNotificationTypeErrorNavBarOverlay(controller,title: "", subtitle: "Doesnt support call function in this device")
//
//        }
//
//
//    }
//
//
//
//    class func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
//        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        color.setFill()
//        UIRectFill(rect)
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return image
//    }
//
//    
//
//    class func addTextToImage(_ text: NSString, inImage: UIImage, atPoint:CGPoint)-> UIImage{
//
//        // Setup the font specific variables
//        let textColor = whiteTextColor
//        let textFont = LATO_BOLD_FONT_20
//
//        //Setups up the font attributes that will be later used to dictate how the text should be drawn
//        let textFontAttributes = [
//            NSAttributedStringKey.font: textFont,
//            NSAttributedStringKey.foregroundColor: textColor,
//            ]
//
//        // Create bitmap based graphics context
//        UIGraphicsBeginImageContextWithOptions(inImage.size, false, 0.0)
//        
//        //Put the image into a rectangle as large as the original image.
//        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
//        
//        // Our drawing bounds
//        let drawingBounds = CGRect(x: 0.0, y: 0.0, width: inImage.size.width, height: inImage.size.height)
//
//        let textSize = text.size(withAttributes: [NSAttributedStringKey.font:textFont])
//        let textRect = CGRect(x: drawingBounds.size.width/2 - textSize.width/2, y: drawingBounds.size.height/2 - textSize.height/2,
//                                  width: textSize.width, height: textSize.height)
//
//        text.draw(in: textRect, withAttributes: textFontAttributes)
//
//        // Get the image from the graphics context
//        let newImag = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        return newImag!
//
//    }
//    
//    
//    class func getFirstLetter(_ text: String)-> String{
//        
//        let stringInputArr = text.components(separatedBy: " ")
//        var stringNeed = ""
//
//        for string in stringInputArr {
//            stringNeed = stringNeed + String(string.characters.first!)
//        }
//        
//        print(stringNeed)
//        
//        return stringNeed
//        
//    }
//    
//
//    
//    class func getLast4Characters(_ text: String) -> String {
//        
//        let last4 = String(text.characters.suffix(4))
//        return last4
//    }
//    
//    //let last4 = a.substring(from:a.index(a.endIndex, offsetBy: -4))
//
//
//
//    
//    class func isValidNcellNTCSmartCellMobile(_ strBillpaycode: String)-> Bool{
//        
//        if (strBillpaycode == BillPaymentConstant.kNcellMobile || strBillpaycode == BillPaymentConstant.kNTCPrepaid || strBillpaycode == BillPaymentConstant.kNTCPostpaid || strBillpaycode == BillPaymentConstant.kSmartCell){
//            return true
//
//        }else{
//
//            return false
//
//        }
//    }
//
//    
//    class func isValidNTCLandLine(_ strBillpaycode: String)-> Bool{
//        
//        if (strBillpaycode == BillPaymentConstant.kNTCLandLine || strBillpaycode == BillPaymentConstant.kADSL_UNLIMITED || strBillpaycode == BillPaymentConstant.kADSL_VOLUME ){
//
//            return true
//            
//        }else{
//            
//            return false
//            
//        }
//    }
//    
//    
//    class func isValidSubisu(_ strBillpaycode: String)-> Bool{
//        
//        if (strBillpaycode == BillPaymentConstant.kSubisu ){
//            
//            return true
//            
//        }else{
//            
//            return false
//
//        }
//    }
//
//    
//    class func isValidTrafficBill(_ strBillpaycode: String)-> Bool{
//
//        if (strBillpaycode == BillPaymentConstant.kTraffic ){
//
//            return true
//
//        }else{
//
//            return false
//
//        }
//    }
//    
//
//
//
//    class func getDocumentsDirectory() -> String {
//        
//
//        let pdfData = NSMutableData()
//        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        pdfData.write(toFile: "\(documentsPath)/file.pdf", atomically: true)
//
//        let url = URL(fileURLWithPath: documentsPath)
//
//        return String(describing: url)
//
//
//
//    }
//    class func PDFGenerator(_ aView: UIView, saveToDocumentsWithFileName fileName: String)-> NSMutableData{
//
//        let pdfData = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil)
//        UIGraphicsBeginPDFPage()
//
//        guard let pdfContext = UIGraphicsGetCurrentContext() else {   return pdfData }
//
//        aView.layer.render(in: pdfContext)
//        UIGraphicsEndPDFContext()
//
//        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
//            let documentsFileName = documentDirectories + "/" + fileName
//            debugPrint(documentsFileName)
//            pdfData.write(toFile: documentsFileName, atomically: true)
//        }
//
//        return pdfData
//    }
//
//    
//
//    class func askForCameraPermission(_ controller: UIViewController) {
//        let alert = UIAlertController(title: "Permission to Camera", message: "Camera access required for QRCode Scanning", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
//            let url = URL(string: UIApplicationOpenSettingsURLString)!
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url)
//            } else {
//                // Fallback on earlier versions
//                
//            }
//        })
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//
//        controller.present(alert, animated: true, completion: nil)
//
//    }
//
// 
//    class func askForContactsPermission(_ controller: UIViewController) {
//        
//        let alert = UIAlertController(title: "Permission to Contacts", message: "Contacts access required to access Address Book", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
//            let url = URL(string: UIApplicationOpenSettingsURLString)!
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url)
//            } else {
//                // Fallback on earlier versions
//
//            }
//        })
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        
//        controller.present(alert, animated: true, completion: nil)
//        
//    }
//    
//    
//    
//    class func askForLocationPermission(_ controller: UIViewController) {
//        
//        let alert = UIAlertController(title: "Location Access Disabled", message: "Turn on your location setting in Prabhu Pay ", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Go to Settings", style: .default) { _ in
//            let url = URL(string: UIApplicationOpenSettingsURLString)!
//            if #available(iOS 10.0, *) {
//                UIApplication.shared.open(url)
//            } else {
//                // Fallback on earlier versions
//                UIApplication.shared.openURL(url)
//
//            }
//        })
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//
//        controller.present(alert, animated: true, completion: nil)
//
//    }
//
//}



// MARK: - swift 3.0


/*
 extension Utility {
 
 // MARK: - SHOW NOTIFICATIONS
 
 
 
 class func showNotificationTypeError(controller: UIViewController, title: String, subtitle: String) {}
 
 
 class func showNotificationTypeSuccess(controller: UIViewController, title: String, subtitle: String) {}
 
 class func showNotificationTypeErrorNavBarOverlay(controller: UIViewController, title: String, subtitle: String) {}
 
 
 
 
 class func showNotificationTypeSuccessNavBarOverlay(controller: UIViewController, title: String, subtitle: String) {}
 
 
 
 class func showNotificationWarning(controller: UIViewController, title: String, subtitle: String) {}
 
 
 // MARK: - SV PROGRESS HUD
 
 class func ShowSVProgressHUD_White() {}
 
 
 class func ShowSVProgressHUD_Black() {}
 
 
 
 class func ShowSVProgressHUD_White_With_IgnoringInteraction() {}
 
 
 class func ShowSVProgressHUD_Black_With_IgnoringInteraction() {}
 
 
 
 class func DismissSVProgressHUD() {}
 
 class func DismissSVProgressHUD_With_endIgnoringInteraction() {}
 
 
 // MARK: - BEGIN IGNORING INTERACTIONS
 
 class func BEGIN_IGNORING_INTERACTIONS() {}
 
 
 class func END_IGNORING_INTERACTIONS() {}
 
 
 
 // MARK: - IQKeyboardManagerSwift
 
 class func ENABLE_IQKEYBOARD() {}
 
 class func DISABLE_IQKEYBOARD() {}
 
 
 class func ENABLE_IQKEYBOARD_AUTO_TOOLBAR() {}
 
 class func DISABLE_IQKEYBOARD_AUTO_TOOLBAR() {}
 
 
 class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{}
 
 
 class func makeCall(controller: UIViewController,phone: String) {}
 
 
 
 class func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
 let rect = CGRectMake(0, 0, size.width, size.height)
 UIGraphicsBeginImageContextWithOptions(size, false, 0)
 color.setFill()
 UIRectFill(rect)
 let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
 UIGraphicsEndImageContext()
 return image
 }
 
 
 
 class func addTextToImage(text: NSString, inImage: UIImage, atPoint:CGPoint)-> UIImage{
 
 // Setup the font specific variables
 let textColor = whiteTextColor
 let textFont = LATO_BOLD_FONT_20
 
 //Setups up the font attributes that will be later used to dictate how the text should be drawn
 let textFontAttributes = [
 NSFontAttributeName: textFont,
 NSForegroundColorAttributeName: textColor,
 ]
 
 // Create bitmap based graphics context
 UIGraphicsBeginImageContextWithOptions(inImage.size, false, 0.0)
 
 //Put the image into a rectangle as large as the original image.
 inImage.drawInRect(CGRectMake(0, 0, inImage.size.width, inImage.size.height))
 
 // Our drawing bounds
 let drawingBounds = CGRectMake(0.0, 0.0, inImage.size.width, inImage.size.height)
 
 let textSize = text.sizeWithAttributes([NSFontAttributeName:textFont])
 let textRect = CGRectMake(drawingBounds.size.width/2 - textSize.width/2, drawingBounds.size.height/2 - textSize.height/2,
 textSize.width, textSize.height)
 
 text.drawInRect(textRect, withAttributes: textFontAttributes)
 
 // Get the image from the graphics context
 let newImag = UIGraphicsGetImageFromCurrentImageContext()
 UIGraphicsEndImageContext()
 
 return newImag
 
 }
 
 
 class func getFirstLetter(text: String)-> String{
 
 let stringInputArr = text.componentsSeparatedByString(" ")
 var stringNeed = ""
 
 for string in stringInputArr {
 stringNeed = stringNeed + String(string.characters.first!)
 }
 
 print(stringNeed)
 
 return stringNeed
 
 }
 
 
 
 
 
 
 
 
 class func isValidNcellNTCMobile(strBillpaycode: String)-> Bool{
 
 if (strBillpaycode == BillPaymentConstant.kNcellMobile || strBillpaycode == BillPaymentConstant.kNTCPrepaid || strBillpaycode == BillPaymentConstant.kNTCPostpaid){
 
 return true
 
 }else{
 
 return false
 
 }
 }
 
 
 class func isValidNTCLandLine(strBillpaycode: String)-> Bool{
 
 if (strBillpaycode == BillPaymentConstant.kNTCLandLine || strBillpaycode == BillPaymentConstant.kADSL_UNLIMITED || strBillpaycode == BillPaymentConstant.kADSL_VOLUME ){
 
 return true
 
 }else{
 
 return false
 
 }
 }
 
 
 class func isValidSubisu(strBillpaycode: String)-> Bool{
 
 if (strBillpaycode == BillPaymentConstant.kSubisu ){
 
 return true
 
 }else{
 
 return false
 
 }
 }
 
 
 class func isValidTrafficBill(strBillpaycode: String)-> Bool{
 
 if (strBillpaycode == BillPaymentConstant.kTraffic ){
 
 return true
 
 }else{
 
 return false
 
 }
 }
 
 class func isBillpaycode(strBillpaycode: String)-> Bool{
 
 if (strBillpaycode == BillPaymentConstant.kNcellMobile || strBillpaycode == BillPaymentConstant.kNTCPrepaid || strBillpaycode == BillPaymentConstant.kNTCPostpaid){
 
 //NcellNTCMobile
 
 return true
 
 }else if (strBillpaycode == BillPaymentConstant.kNTCLandLine || strBillpaycode == BillPaymentConstant.kADSL_UNLIMITED || strBillpaycode == BillPaymentConstant.kADSL_VOLUME ){
 
 //NTCLandLine
 
 return true
 
 }/*else if (strBillpaycode == BillPaymentConstant.kSubisu ){
 
 return true
 
 }*/else{
 
 return false
 
 }
 }
 
 
 
 }
 
 */
