//
//  UserDefaultsManager.swift
//  EveryDayVoca
//
//  Created by 문기웅 on 5/22/24.
//

import Foundation
import UIKit

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let userDefaults = UserDefaults.standard
    

    private init() {
        defaultsSet()
        
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
            "userName" : "사용자 이름",
            "userNickName" : "닉네임",
            "studyLevel" : "Lv. 1",
            "studyAmount" : "10개"
        ]
        userDefaults.register(defaults: defaults)
    }

    func set(value: String, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }

    func getValue(key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    func setImageConvert(value: UIImage, key: String) {
        let imageData = value.jpegData(compressionQuality: 1.0)
        userDefaults.set(imageData, forKey: key)
    }

    @objc private func userDefaultsDidChange(_ notification: Notification) {
        NotificationCenter.default.post(name: .userDefaultsDidChange, object: nil)
    }
}

extension Notification.Name {
    static let userDefaultsDidChange = Notification.Name("userDefaultsDidChange")
}
