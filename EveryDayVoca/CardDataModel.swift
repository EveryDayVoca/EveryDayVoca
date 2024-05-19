//
//  CardDataModel.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/19/24.
//

import Foundation

struct CardDataModel {
    
    var word : String
    var meaning : String
    var options : Options
      
    init(word: String, meaning: String, options: Options) {
        self.word = word
        self.meaning = meaning
        self.options = options
    }
}

enum Options: String {
    case perfect = "외웠어요"
    case normal = "애매해요"
    case difficult = "어려워요"
}
