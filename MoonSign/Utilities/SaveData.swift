//
//  SaveData.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

class SaveData{
    static let loggedIn = "IS_LOGGED_IN"
    static let customerID = "CUSTOMER_ID"
    static let welcomeMessage = "WELCOME_MESSAGE"
    static let registeredStatus = "REGISTER_STATUS"
    static let moderatorName = "MODERATOR_NAME"
    static let moderatorImageURL = "MODERATOR_IMAGE_URL"
    static let profileImageURL = "PROFILE_IMAGE_URL"
    static let DEVICE_TOKEN     = "device_token"
    static let FREE_QUESTIONS = "free_questions"
    
    static func saveDeviceToken(_ deviceToken: String){
        UserDefaults.standard.set(deviceToken, forKey: SaveData.DEVICE_TOKEN)
    }
    static func getDeviceToken()->String{
        return UserDefaults.standard.string(forKey: SaveData.DEVICE_TOKEN) ?? ""
    }
    static func isLoggedIn() -> Bool{
        let flag = UserDefaults.standard.bool(forKey: loggedIn)
        return flag
    }
    static func setLoggedIn(flag: Bool){
        UserDefaults.standard.set(flag, forKey: loggedIn)
    }
    
    static func getCustomerID() -> String?{
        let id = UserDefaults.standard.string(forKey: customerID)
      
        return id
    }
    
    static func setCustomerID(id: String){
        UserDefaults.standard.set(id, forKey: customerID)
    }
    
    static func setWelcomeMessage(message: [String:String]){
        UserDefaults.standard.set(message, forKey: welcomeMessage)
    }
    
    static func getWelcomeMessage() -> [String:String]{
       let message = UserDefaults.standard.dictionary(forKey: welcomeMessage)
        
        return message as! [String : String]
    }
    
    static func isRegistered() -> Bool {
      return  UserDefaults.standard.bool(forKey: registeredStatus)
    }
    
    static func setRegisteredStatus(flag : Bool){
        UserDefaults.standard.set(flag, forKey: registeredStatus)
    }
    
    static func setModeratorName(name: String){
        UserDefaults.standard.set(name, forKey: moderatorName)
    }
    static func getModeratorName() -> String{
        return UserDefaults.standard.string(forKey: moderatorName) ?? "Moonsign"
    }
    
    static func setModeratorImageURL(url: String){
        UserDefaults.standard.set(URL(string: url), forKey: moderatorImageURL)
    }
    
    static func getModeratorImageURL() -> URL {
        guard let url = UserDefaults.standard.url(forKey: moderatorImageURL)
            else{
                    return  Utility.createLocalUrl(forImageNamed: "profiledefault")!
                }
        return url
    }
    
    static func setProfileImageURL(url: String){
        UserDefaults.standard.set(URL(string: url), forKey: profileImageURL)
    }
    
    static func getProfileImageURL() -> URL {
        guard let url = UserDefaults.standard.url(forKey: profileImageURL)
            else{
                return  Utility.createLocalUrl(forImageNamed: "profiledefault")!
        }
        return url
    }
    
    static func setFreeQuestions(value: Int){
        UserDefaults.standard.set(value, forKey: SaveData.FREE_QUESTIONS)
    }
    static func getFreeQuestions() -> Int{
        let num = UserDefaults.standard.integer(forKey: SaveData.FREE_QUESTIONS)
        
        return num
    }
}
