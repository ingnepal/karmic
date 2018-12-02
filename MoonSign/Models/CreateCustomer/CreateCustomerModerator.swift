//
//  CreateCustomerModerator.swift
//  MoonSign
//
//  Created by Mac on 11/18/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

import Foundation

struct CreateCustomerModerator : Codable {
    
    let id : String?
    let imageUrl : String?
    let name : String?
    let qualification : String?
    let roleNames : String?
    let userName : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case imageUrl = "ImageUrl"
        case name = "Name"
        case qualification = "Qualification"
        case roleNames = "RoleNames"
        case userName = "UserName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        qualification = try values.decodeIfPresent(String.self, forKey: .qualification)
        roleNames = try values.decodeIfPresent(String.self, forKey: .roleNames)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
    }
    
}
