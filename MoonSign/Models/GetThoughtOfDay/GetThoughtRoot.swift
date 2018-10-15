//
//  GetThoughtRoot.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetThoughtRoot : Codable {
    
    let data : GetThoughtData?
    let meta : GetThoughtMeta?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(GetThoughtData.self, forKey: .data)
        meta = try values.decodeIfPresent(GetThoughtMeta.self, forKey: .meta)
    }
    
}
