//
//  UserModel.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/21/24.
//

import Foundation


struct UserModel {
    let userDefaults = UserDefaults.standard
    
    init() {
        userDefaults.set("이름", forKey: "userName")
    }
}
