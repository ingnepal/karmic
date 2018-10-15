//
//  UpdateCustomerRoot.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct UpdateCustomerRoot : Codable {
    
    let data : UpdateCustomerData?
    let meta : UpdateCustomerMeta?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UpdateCustomerData.self, forKey: .data)
        meta = try values.decodeIfPresent(UpdateCustomerMeta.self, forKey: .meta)
    }
    
}
