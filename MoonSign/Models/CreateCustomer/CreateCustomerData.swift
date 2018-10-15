//
//  CreateCustomerData.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct CreateCustomerData : Codable {
    
    let conversation : CreateCustomerConversation?
    let customerDetail : CreateCustomerDetail?
    
    enum CodingKeys: String, CodingKey {
        case conversation = "Conversation"
        case customerDetail = "CustomerDetail"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        conversation = try values.decodeIfPresent(CreateCustomerConversation.self, forKey: .conversation)
        customerDetail =  try values.decodeIfPresent(CreateCustomerDetail.self, forKey: .customerDetail)
    }
    
}
