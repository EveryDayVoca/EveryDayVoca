//
//  User.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/23/24.
//

import Foundation

struct User: Codable {
    var name: String
    var nickname: String
    var level: Int
    var amount: Int
    var profile: Data
}
