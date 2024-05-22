//
//  UserDefaultsManager.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/22/24.
//

import Foundation
import UIKit

enum UserData: String {
    case level1 = "level1"
    case level2 = "level2"
    case level3 = "level3"
    case level4 = "level4"
    case level5 = "level5"
    
    case total1 = "total1"
    case total2 = "total2"
    case total3 = "total3"
    case total4 = "total4"
    case total5 = "total5"
    
    case userName = "userName"
    case userNickName = "userNickName"
    case studyLevel = "studyLevel"
    case studyAmount = "studyAmount"
    case profileImage = "profileImage"
    
    case launchedBefore = "launchedBefore"
}

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    
    private init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDefaultsDidChange(_:)),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UserDefaults.didChangeNotification,
                                                  object: nil)
    }
    
    
    func defaultsSet() {
        let defaults:[String : Any] = [
            UserData.userName.rawValue : "사용자 이름",
            UserData.userNickName.rawValue : "닉네임",
            UserData.studyLevel.rawValue : "Lv. 1",
            UserData.studyAmount.rawValue : "10개",
            UserData.level1.rawValue : 1,
            UserData.level2.rawValue : 289,
            UserData.level3.rawValue : 889,
            UserData.level4.rawValue : 1277,
            UserData.level5.rawValue : 1412,
            UserData.total1.rawValue : 288,
            UserData.total2.rawValue : 600,
            UserData.total3.rawValue : 388,
            UserData.total4.rawValue : 135,
            UserData.total5.rawValue : 335
        ]
        userDefaults.register(defaults: defaults)
    }
    
    @objc private func userDefaultsDidChange(_ notification: Notification) {
        NotificationCenter.default.post(name: .userDefaultsDidChange, object: nil)
    }
}

extension Notification.Name {
    static let userDefaultsDidChange = Notification.Name("userDefaultsDidChange")
}
