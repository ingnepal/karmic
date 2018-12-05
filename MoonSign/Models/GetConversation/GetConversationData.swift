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
    let astrologer : GetConversationAstrologer?
    let astrologerId : String?
    let customerDto : String?
    let customerId : Int?
    let id : Int?
    let isPaid : Bool?
    let moderator : GetConversationModerator?
    let moderatorDataId : String?
    let moderatorId : String?
    let postedOn : String?
    let purchaseToken : String?
    let questions : String?
    let subscriptionId : String?
    
    enum CodingKeys: String, CodingKey {
        case answer = "Answer"
        case answerId = "AnswerId"
        case astrologer = "Astrologer"
        case astrologerId = "AstrologerId"
        case customerDto = "CustomerDto"
        case customerId = "CustomerId"
        case id = "Id"
        case isPaid = "IsPaid"
        case moderator = "Moderator"
        case moderatorDataId = "ModeratorDataId"
        case moderatorId = "ModeratorId"
        case postedOn = "PostedOn"
        case purchaseToken = "PurchaseToken"
        case questions = "Questions"
        case subscriptionId = "SubscriptionId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        answer = try values.decodeIfPresent(GetConversationAnswer.self, forKey: .answer)
        answerId = try values.decodeIfPresent(Int.self, forKey: .answerId)
        astrologer = try values.decodeIfPresent(GetConversationAstrologer.self, forKey: .astrologer)
        astrologerId = try values.decodeIfPresent(String.self, forKey: .astrologerId)
        customerDto = try values.decodeIfPresent(String.self, forKey: .customerDto)
        customerId = try values.decodeIfPresent(Int.self, forKey: .customerId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isPaid = try values.decodeIfPresent(Bool.self, forKey: .isPaid)
        moderator = try values.decodeIfPresent(GetConversationModerator.self, forKey: .moderator)
        moderatorDataId = try values.decodeIfPresent(String.self, forKey: .moderatorDataId)
        moderatorId = try values.decodeIfPresent(String.self, forKey: .moderatorId)
        postedOn = try values.decodeIfPresent(String.self, forKey: .postedOn)
        purchaseToken = try values.decodeIfPresent(String.self, forKey: .purchaseToken)
        questions = try values.decodeIfPresent(String.self, forKey: .questions)
        subscriptionId = try values.decodeIfPresent(String.self, forKey: .subscriptionId)
    }
    
}
