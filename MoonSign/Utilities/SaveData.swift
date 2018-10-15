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
    
    static func isLoggedIn() -> Bool{
        let flag = UserDefaults.standard.bool(forKey: loggedIn)
        return flag
    }
    static func setLoggedIn(flag: Bool){
        UserDefaults.standard.set(flag, forKey: loggedIn)
    }
    
    static func getCustomerID() -> String{
        let id = UserDefaults.standard.string(forKey: customerID)
        
        return id!
    }
    
    static func setCustomerID(id: String){
        UserDefaults.standard.set(id, forKey: customerID)
    }
}
