//
//  GetYogaData.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetYogaData : Codable {
    
    let details : String?
    let id : Int?
    let imageUrl : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case details = "Details"
        case id = "Id"
        case imageUrl = "ImageUrl"
        case name = "Name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        details = try values.decodeIfPresent(String.self, forKey: .details)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
