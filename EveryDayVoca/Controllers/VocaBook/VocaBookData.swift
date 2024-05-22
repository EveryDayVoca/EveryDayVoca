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
            vocasCount = vocas.count
            print("vocas fetched: \(vocas.count)개")
        }
    }
    lazy var vocasCount = vocas.count
    
    func getVocaData() {
        vocas = vocaDataManager.getVocaData()
    }
    
    func getVocaDeckData(forVocaDeck name: String) {
        vocas = vocaDataManager.getVocaData(forvocaDeck: name)
    }
    
    func updateVocaStatus(_ vocaData: Voca, status: String, index: Int) {
        // 1. CoreData 업데이트
        vocaDataManager.updateVocaStatus(vocaData, status: status)
        
        // 2. VocaBookData.vocas 업데이트
        vocas[index].status = status
    }
    
}
