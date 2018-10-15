//
//  AstrologersListData.swift
//  MoonSign
//
//  Created by Mac on 9/9/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation
struct AstrologersListData : Codable {
    
    let imageUrl : String?
    let qualification : String?
    let roleNames : String?
    let userId : String?
    let userName : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "ImageUrl"
        case qualification = "Qualification"
        case roleNames = "RoleNames"
        case userId = "Id"
        case userName = "UserName"
        case name = "Name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        qualification = try values.decodeIfPresent(String.self, forKey: .qualification)
        roleNames = try values.decodeIfPresent(String.self, forKey: .roleNames)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
