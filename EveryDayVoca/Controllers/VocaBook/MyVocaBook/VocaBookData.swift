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
    
    var dataUpdate: (() -> ())?
    
    var vocas: [Voca] = [] {
        didSet {
            vocasCount = vocas.count
            print("vocas fetched: \(vocas.count)개")
        }
    }
    
    var currentVocaDeck: String = "ALL"
    
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
            
            vocas = []
            let selectedStatus = filters.filter { $0.isSelected }
            for i in selectedStatus {
                vocas.append(contentsOf: VocaCoreDataManager.shared.getVocaData(
                    forvocaDeck: currentVocaDeck,
                    status: i.status))
            }
            dataUpdate!()
        }
    }
    
    var selectedDisplayOption: DisplayOption = .englishAndKorean
    
    lazy var vocasCount = vocas.count
    
    // MARK: - vocas 업데이트 함수
    
    func getVocaData() {
        vocas = vocaDataManager.getVocaData()
    }
    
    func getVocaData(forVocaDeck name: String) {
        if name == "ALL" {
            vocas = vocaDataManager.getVocaData()
        } else {
            vocas = vocaDataManager.getVocaData(forvocaDeck: name)
        }
    }
    
    func getVocaDatas(forVocaDeck name: String) -> [Voca] {
        if name == "ALL" {
            return vocaDataManager.getVocaData()
        } else {
            return vocaDataManager.getVocaData(forvocaDeck: name)
        }
    }
    
    func updateVocaStatus(_ vocaData: Voca, status: Status, index: Int) {
        // 1. CoreData 업데이트
        vocaDataManager.updateVocaStatus(vocaData, status: status)
        
        // 2. VocaBookData.vocas 업데이트
        if currentVocaDeck == "ALL" {
            vocas = vocaDataManager.getVocaData()
        } else {
            vocas = vocaDataManager.getVocaData(forvocaDeck: currentVocaDeck)
        }
        vocas[index].status = status.rawValue
    }
    
    
    // MARK: - vocaDecks 업데이트 함수
    
    func getVocaDeckData() {
        vocaDecks = vocaDataManager.getVocaDeckData()
    }
    
    
}
