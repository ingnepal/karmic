//
//  GetYogaRoot.swift
//  MoonSign
//
//  Created by Mac on 9/25/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetYogaRoot : Codable {
    
    let data : [GetYogaData]?
    let meta : GetYogaMeta?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([GetYogaData].self, forKey: .data)
        meta = try values.decodeIfPresent(GetYogaMeta.self, forKey: .meta)
    }
    
}
