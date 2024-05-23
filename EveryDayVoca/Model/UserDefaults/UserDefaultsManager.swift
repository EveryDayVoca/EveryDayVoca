//
//  UserDefaultsManager.swift
//  EveryDayVoca
//
//  Created by 김정호 on 5/23/24.
//

import UIKit

final class UserDefaultsManager {
    
    // MARK: - properties
    static let shared = UserDefaultsManager()
    private init() { }
    
    private let encoder: JSONEncoder = JSONEncoder()
    private let decoder: JSONDecoder = JSONDecoder()
    
    private let userKey = "user"
    private let progressKey = "progress"
    
    func fetchUser() -> User {
        if let user = UserDefaults.standard.object(forKey: userKey) as? Data {
            if let decodedUser = try? decoder.decode(User.self, from: user) {
                return decodedUser
            }
        } else {
            let initUser = User(name: "사용자 이름", nickname: "닉네임", level: 1, amount: 10, profile: UIImage.userProfile.jpegData(compressionQuality: 1.0) ?? Data())
            
            if let encodedInitUser = try? encoder.encode(initUser) {
                UserDefaults.standard.set(encodedInitUser, forKey: userKey)
                return initUser
            }
            
            return initUser
        }
        
        return User(name: "사용자 이름", nickname: "닉네임", level: 1, amount: 10, profile: Data())
    }
    
    func fetchProgress() -> Progress {
        if let progress = UserDefaults.standard.object(forKey: progressKey) as? Data {
            if let decodedProgress = try? decoder.decode(Progress.self, from: progress) {
                return decodedProgress
            }
        } else {
            let initProgress = Progress(lv1: 1, lv2: 5, lv3: 10, lv4: 15, lv5: 20)
            
            if let encodedInitProgress = try? encoder.encode(initProgress) {
                UserDefaults.standard.set(encodedInitProgress, forKey: progressKey)
                return initProgress
            }
        }
        
        return Progress(lv1: 1, lv2: 5, lv3: 10, lv4: 15, lv5: 20)
    }
    
    func fetchStartIndex() -> Int {
        let level = fetchUser().level
        let progress = fetchProgress()
        
        switch level {
        case 1:
            return progress.lv1
        case 2:
            return progress.lv2
        case 3:
            return progress.lv3
        case 4:
            return progress.lv4
        default:
            return progress.lv5
        }
    }
    
    func updateUser(user: User) -> Bool {
        if let encodedUser = try? encoder.encode(user) {
            UserDefaults.standard.set(encodedUser, forKey: userKey)
            return true
        }
        
        return false
    }
    
    func updateStartIndex() -> Bool {
        let user = fetchUser()
        var progress = fetchProgress()
        
        switch user.level {
        case 1:
            progress.lv1 += user.amount
        case 2:
            progress.lv2 += user.amount
        case 3:
            progress.lv3 += user.amount
        case 4:
            progress.lv4 += user.amount
        default:
            progress.lv5 += user.amount
        }
        
        if let encodedProgress = try? encoder.encode(progress) {
            UserDefaults.standard.set(encodedProgress, forKey: progressKey)
            return true
        }
        
        return false
    }
}
