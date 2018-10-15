
//
//  UpdateCustomerData.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct UpdateCustomerData : Codable {
    
    let accurateDOB : Bool?
    let age : Int?
    let cityRegion : String?
    let country : String?
    let deviceToken : String?
    let dOB : String?
    let gender : String?
    let id : Int?
    let imageUrl : String?
    let macAddress : String?
    let profileName : String?
    let repeatedDOB : Bool?
    let rightName : String?
    let vedicSignId : String?
    
    enum CodingKeys: String, CodingKey {
        case accurateDOB = "AccurateDOB"
        case age = "Age"
        case cityRegion = "CityRegion"
        case country = "Country"
        case deviceToken = "DeviceToken"
        case dOB = "DOB"
        case gender = "Gender"
        case id = "Id"
        case imageUrl = "ImageUrl"
        case macAddress = "MacAddress"
        case profileName = "ProfileName"
        case repeatedDOB = "RepeatedDOB"
        case rightName = "RightName"
        case vedicSignId = "VedicSignId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accurateDOB = try values.decodeIfPresent(Bool.self, forKey: .accurateDOB)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        cityRegion = try values.decodeIfPresent(String.self, forKey: .cityRegion)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
        dOB = try values.decodeIfPresent(String.self, forKey: .dOB)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        macAddress = try values.decodeIfPresent(String.self, forKey: .macAddress)
        profileName = try values.decodeIfPresent(String.self, forKey: .profileName)
        repeatedDOB = try values.decodeIfPresent(Bool.self, forKey: .repeatedDOB)
        rightName = try values.decodeIfPresent(String.self, forKey: .rightName)
        vedicSignId = try values.decodeIfPresent(String.self, forKey: .vedicSignId)
    }
    
}
