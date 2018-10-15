//
//  GetThoughtData.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetThoughtData : Codable {
    
    let thoughtOfTheDay : String?
    
    enum CodingKeys: String, CodingKey {
        case thoughtOfTheDay = "ThoughtOfTheDay"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        thoughtOfTheDay = try values.decodeIfPresent(String.self, forKey: .thoughtOfTheDay)
    }
    
}
