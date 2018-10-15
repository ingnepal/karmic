//
//  GetConversationData.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetConversationData : Codable {
    
    let answer : GetConversationAnswer?
    let answerId : Int?
    let customerDto : String?
    let customerId : Int?
    let id : Int?
    let moderatorDataId : String?
    let questions : String?
    
    enum CodingKeys: String, CodingKey {
        case answer = "Answer"
        case answerId = "AnswerId"
        case customerDto = "CustomerDto"
        case customerId = "CustomerId"
        case id = "Id"
        case moderatorDataId = "ModeratorDataId"
        case questions = "Questions"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        answer = try values.decodeIfPresent(GetConversationAnswer.self, forKey: .answer)
        answerId = try values.decodeIfPresent(Int.self, forKey: .answerId)
        customerDto = try values.decodeIfPresent(String.self, forKey: .customerDto)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        moderatorDataId = try values.decodeIfPresent(String.self, forKey: .moderatorDataId)
        questions = try values.decodeIfPresent(String.self, forKey: .questions)
    }
    
}
