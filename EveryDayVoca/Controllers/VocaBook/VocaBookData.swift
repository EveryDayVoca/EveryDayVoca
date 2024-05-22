//
//  VocaBookData.swift
//  EveryDayVoca
//
//  Created by 유림 on 5/22/24.
//

import Foundation

class VocaBookData {
    
    static let shared = VocaBookData()
    
    var vocaDataManager = VocaCoreDataManager.shared
    
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
    
    var filters: [Filter] = [Filter(status: .difficult, isSelected: true),
                             Filter(status: .ambiguous, isSelected: true),
                             Filter(status: .memorized, isSelected: true),
                             Filter(status: .none, isSelected: true)]  {
        didSet {
            print("데이터에서 필터 업데이트됨")
        }
    }
    
    var selectedDisplayOption: DisplayOption = .englishAndKorean
    
    lazy var vocasCount = vocas.count
    
    // MARK: - vocas 업데이트 함수
    
    func getVocaData() {
        vocas = vocaDataManager.getVocaData()
    }
    
    func getVocaData(forVocaDeck name: String) {
        vocas = vocaDataManager.getVocaData(forvocaDeck: name)
    }
    
    func updateVocaStatus(_ vocaData: Voca, status: Status, index: Int) {
        // 1. CoreData 업데이트
        vocaDataManager.updateVocaStatus(vocaData, status: status)
        
        // 2. VocaBookData.vocas 업데이트
        vocas[index].status = status.rawValue
    }
    
    
    // MARK: - vocaDecks 업데이트 함수
    
    func getVocaDeckData() {
        vocaDecks = vocaDataManager.getVocaDeckData()
    }
    
    
}
