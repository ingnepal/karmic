//
//  AstrologersListRoot.swift
//  MoonSign
//
//  Created by Mac on 9/9/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct AstrologersListRoot : Codable {
    
    let data : [AstrologersListData]?
    let meta : AstrologersListMeta?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([AstrologersListData].self, forKey: .data)
        meta = try AstrologersListMeta(from: decoder)
    }
    
}
