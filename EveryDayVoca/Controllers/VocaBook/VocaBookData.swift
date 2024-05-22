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
    
    var vocaDecks: [VocaDeck] = [] {
        didSet {
            print("vocaDecks fetched: \(vocaDecks.count)개")
        }
    }
    
    lazy var vocasCount = vocas.count
    
    // MARK: - vocas 업데이트 함수
    
    func getVocaData() {
        vocas = vocaDataManager.getVocaData()
    }
    
    func getVocaData(forVocaDeck name: String) {
        vocas = vocaDataManager.getVocaData(forvocaDeck: name)
    }
    
    func updateVocaStatus(_ vocaData: Voca, status: String, index: Int) {
        // 1. CoreData 업데이트
        vocaDataManager.updateVocaStatus(vocaData, status: status)
        
        // 2. VocaBookData.vocas 업데이트
        vocas[index].status = status
    }
    
    
    // MARK: - vocaDecks 업데이트 함수
    
    func getVocaDeckData() {
        vocaDecks = vocaDataManager.getVocaDeckData()
    }
    
    
}
