//
//  GetTemplateMeta.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetTemplateMeta : Codable {
    
    let message : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status = "Status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
    }
    
}
