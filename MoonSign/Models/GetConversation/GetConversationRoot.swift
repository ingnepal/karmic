//
//  GetConversationRoot.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetConversationRoot : Codable {
    
    let data : [GetConversationData]?
    let meta : GetConversationMeta?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([GetConversationData].self, forKey: .data)
        meta = try values.decodeIfPresent(GetConversationMeta.self, forKey: .meta)
    }
    
}
