//
//  GetTemplateQuestionList.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetTemplateQuestionList : Codable {
    
    let id : Int?
    let questionCategoryId : Int?
    let questionExample : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case questionCategoryId = "QuestionCategoryId"
        case questionExample = "QuestionExample"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        questionCategoryId = try values.decodeIfPresent(Int.self, forKey: .questionCategoryId)
        questionExample = try values.decodeIfPresent(String.self, forKey: .questionExample)
    }
    
}
