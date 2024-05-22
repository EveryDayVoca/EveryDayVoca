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
        
        userDefaults.set(288, forKey: "1total")
        userDefaults.set(600, forKey: "2total")
        userDefaults.set(388, forKey: "3total")
        userDefaults.set(135, forKey: "4total")
        userDefaults.set(335, forKey: "5total")
        
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDefaultsDidChange(_:)),
                                               name: UserDefaults.didChangeNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UserDefaults.didChangeNotification,
                                                  object: nil)
    }
    
    func setVocaCount() {
        
    }
    
    func defaultsSet() {
        let defaults:[String : Any] = [
            "userName" : "사용자 이름",
            "userNickName" : "닉네임",
            "studyLevel" : "Lv. 1",
            "studyAmount" : "10개",
            "lastStudyIndex" : 1
        ]
        userDefaults.register(defaults: defaults)
    }

    func set(value: String, key: String) {
        userDefaults.set(value, forKey: key)
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
