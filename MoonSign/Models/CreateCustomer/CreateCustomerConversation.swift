//
//  CreateCustomerConversation.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct CreateCustomerConversation : Codable {
    
    let answer : CreateCustomerAnswers?
    let answerId : Int?
    let customerDto : String?
    let customerId : Int?
    let id : Int?
    let moderator : CreateCustomerModerator?
    let moderatorDataId : String?
    let moderatorId : String?
    let questions : String?
    
    enum CodingKeys: String, CodingKey {
        case answer = "Answer"
        case answerId = "AnswerId"
        case customerDto = "CustomerDto"
        case customerId = "CustomerId"
        case id = "Id"
        case moderator = "Moderator"
        case moderatorDataId = "ModeratorDataId"
        case moderatorId = "ModeratorId"
        case questions = "Questions"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        answer = try values.decodeIfPresent(CreateCustomerAnswers.self, forKey: .answer)
        answerId = try values.decodeIfPresent(Int.self, forKey: .answerId)
        customerDto = try values.decodeIfPresent(String.self, forKey: .customerDto)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        moderator = try values.decodeIfPresent(CreateCustomerModerator.self, forKey: .moderator)
        moderatorDataId = try values.decodeIfPresent(String.self, forKey: .moderatorDataId)
        moderatorId = try values.decodeIfPresent(String.self, forKey: .moderatorId)
        questions = try values.decodeIfPresent(String.self, forKey: .questions)
    }
    
}
