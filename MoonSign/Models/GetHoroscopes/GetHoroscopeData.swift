//
//  GetHoroscopeData.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetHoroscopeData : Codable {
    
    let detail : String?
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case detail = "Detail"
        case id = "Id"
        case name = "Name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        detail = try values.decodeIfPresent(String.self, forKey: .detail)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
