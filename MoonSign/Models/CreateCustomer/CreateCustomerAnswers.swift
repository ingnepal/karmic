//
//  CreateCustomerAnswers.swift
//  MoonSign
//
//  Created by Mac on 9/23/18.
//  Copyright © 2018 BlackSpring. All rights reserved.
//

import Foundation

struct CreateCustomerAnswers : Codable {
    
    let answers : String?
    let id : Int?
    let rating : Int?
    
    enum CodingKeys: String, CodingKey {
        case answers = "Answers"
        case id = "Id"
        case rating = "Rating"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        answers = try values.decodeIfPresent(String.self, forKey: .answers)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        rating = try values.decodeIfPresent(Int.self, forKey: .rating)
    }
    
}
