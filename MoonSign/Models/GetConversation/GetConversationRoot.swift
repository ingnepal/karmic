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
    let freeQuestions : Int?
    let meta : GetConversationMeta?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case freeQuestions = "FreeQuestions"
        case meta = "Meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([GetConversationData].self, forKey: .data)
        freeQuestions = try values.decodeIfPresent(Int.self, forKey: .freeQuestions)
        meta = try values.decodeIfPresent(GetConversationMeta.self, forKey: .meta)
    }
    
}
