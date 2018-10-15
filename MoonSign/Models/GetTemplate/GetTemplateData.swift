//
//  GetTemplateData.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct GetTemplateData : Codable {
    
    let id : Int?
    let name : String?
    let questionList : [GetTemplateQuestionList]?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case questionList = "QuestionList"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        questionList = try values.decodeIfPresent([GetTemplateQuestionList].self, forKey: .questionList)
    }
    
}
