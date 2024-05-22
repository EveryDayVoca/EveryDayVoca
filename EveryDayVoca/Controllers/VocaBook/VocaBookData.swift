//
//  VocaBookData.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/22/24.
//

import Foundation

class VocaBookData {
    
    static let shared = VocaBookData()
    
    var vocaDataManager = vocaCoreDataManager.shared
    var vocas: [Voca] = [] {
        didSet {
            print("vocas fetched: \(vocas.count)개")
        }
    }
    
    func getVocaData() {
        vocas = vocaDataManager.getVocaData()
    }
    
    func getVocaDeckData(forVocaDeck name: String) {
        vocas = vocaDataManager.getVocaData(forvocaDeck: name)
    }
    
}
