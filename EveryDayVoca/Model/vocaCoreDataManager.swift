//
//  vocaCoreDataManager.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/20/24.
//

import Foundation
import UIKit
import CoreData

final class vocaCoreDataManager {
    
    static let shared = vocaCoreDataManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let vocaDeckModel: String = "VocaDeck"
    let vocaModel: String = "Voca"
    let dateModel: String = "VocaDate"
    
    
    // MARK: - Voca CoreData
    
    func createdVocaDatas(words: [(english: String, korean: String)], vocaDeck: VocaDeck) {
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: vocaModel, in: context) else {
            return
        }
        
        for word in words {
            let newData = Voca(entity: entity, insertInto: context)
            newData.english = word.english
            newData.korean = word.korean
            newData.status = "미학습"
            newData.vocaDeck = vocaDeck.name
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save words: \(error)")
        }
    }
    
    func createVocaData(english: String, korean: String, vocaDeck: VocaDeck) {
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: vocaModel, in: context) else {
            return
        }
        
        let newData = Voca(entity: entity, insertInto: context)
        
        newData.english = english
        newData.korean = korean
        newData.status = "미학습"
        newData.vocaDeck = vocaDeck.name
        
        do {
            try context.save()
            print("코어데이터 저장 성공")
        } catch {
            print("코어데이터 저장 중 에러 \(error)")
        }
    }
    
    func getVocaData(forvocaDeck vocaDeck: VocaDeck) -> [Voca] {
        var vocaList = [Voca]()
        
        guard let context = context else {
            return vocaList
        }
        
        let fetchRequest: NSFetchRequest<Voca> = Voca.fetchRequest()
        
        guard let deckName = vocaDeck.name else { return vocaList }
        
        if deckName != "ALL" {
            let predicate = NSPredicate(format: "vocaDeck == %@", vocaDeck.name!)
            fetchRequest.predicate = predicate
        }
        
        do {
            vocaList = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        return vocaList
    }
    
    func getVocaDataWithIndex(index: Int, count: Int) -> [Voca] {
        var vocaList = [Voca]()
        
        guard let context = context else {
            return vocaList
        }
        
        let fetchRequest: NSFetchRequest<Voca> = Voca.fetchRequest()
        
        fetchRequest.fetchOffset = index
        fetchRequest.fetchLimit = count
        
        do {
            vocaList = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        return vocaList
    }
    
    func updateVocaStatus(_ vocaData: Voca, status: String) {
        guard let context = context else {
            return
        }
        vocaData.status = status
        
        do {
            try context.save()
        } catch {
            print("코어데이터 업데이트 중 에러 \(error)")
        }
    }
    
    func updateVocaDatas(vocadatas: [(vocaData: Voca, status: String)]) {
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: vocaModel, in: context) else {
            return
        }
        
        for voca in vocadatas {
            voca.vocaData.status = voca.status
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save words: \(error)")
        }
    }
    
    func getStudyData(vocaData: [Voca]) -> [status: Int] {
        var studyData: [status: Int] = [.memorized: 0, .ambiguous: 0, .difficult: 0, .none: 0]
        
        for data in vocaData {
            switch data.status {
            case "외웠어요":
                studyData[.memorized]! += 1
            case "애매해요":
                studyData[.ambiguous]! += 1
            case "어려워요":
                studyData[.difficult]! += 1
            default:
                studyData[.none]! += 1
            }
        }
        
        return studyData
    }
    
    
    // MARK: - VocaDeck CoreData
    
    func createVocaDeckData(vocaDeckName: String) {
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: vocaDeckName, in: context) else {
            return
        }
        
        let newData = VocaDeck(entity: entity, insertInto: context)
        
        newData.setValue(vocaDeckName, forKey: "name")
        newData.setValue(0, forKey: "count")
        
        do {
            try context.save()
            print("코어데이터 저장 성공")
        } catch {
            print("코어데이터 저장 중 에러 \(error)")
        }
    }
    
    func getVocaDeckData() -> [VocaDeck] {
        var vocaDeckList = [VocaDeck]()
        
        guard let context = context else {
            return vocaDeckList
        }
        
        let fetchRequest: NSFetchRequest<VocaDeck> = VocaDeck.fetchRequest()
        
        do {
            vocaDeckList = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        return vocaDeckList
    }
    
    func updateVocaDeckCount(_ vocaDeck: VocaDeck) {
        guard let context = context else {
            return
        }
        vocaDeck.count += 1
        
        do {
            try context.save()
        } catch {
            print("코어데이터 업데이트 중 에러 \(error)")
        }
    }
    
    // MARK: - VocaDate CoreData
    
    func createVocaDateData(index: Int, count: Int) {
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: dateModel, in: context) else {
            return
        }
        
        let newData = VocaDate(entity: entity, insertInto: context)
        
        newData.createdAt = Date()
        newData.leadWordIndex = Int64(index)
        newData.studiedWordCount = 0
        newData.totalWordCount = Int64(count)
        
        do {
            try context.save()
            print("코어데이터 저장 성공")
        } catch {
            print("코어데이터 저장 중 에러 \(error)")
        }
    }
    
    func getVocaDateData(date: Date) -> [VocaDate] {
        var vocaDate = [VocaDate]()
        
        guard let context = context else {
            return vocaDate
        }
        
        let fetchRequest: NSFetchRequest<VocaDate> = VocaDate.fetchRequest()
        
        let predicate = NSPredicate(format: "createAt == %@", date as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            vocaDate = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        return vocaDate
    }
    
    func getVocaMonthDates(forYear year: Int, month: Int) -> [VocaDate] {
        
        var vocaDateData = [VocaDate]()
        
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: dateModel, in: context) else {
            return vocaDateData
        }
        
        let fetchRequest: NSFetchRequest<VocaDate> = VocaDate.fetchRequest()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        
        let dateComponents = DateComponents(year: year, month: month)
        let startDate = calendar.date(from: dateComponents)!
        let endDate = calendar.date(byAdding: .month, value: 1, to: startDate)!
        
        let datePredicate = NSPredicate(format: "(createdAt >= %@) AND (createdAt < %@)", startDate as NSDate, endDate as NSDate)
        fetchRequest.predicate = datePredicate
        
        do {
            vocaDateData = try context.fetch(fetchRequest)
        } catch {
            print("Error fetching data: \(error)")
        }
        
        return vocaDateData
    }
    
    func updateVocaDateStudiedWordCount(_ data: VocaDate, count: Int) {
        guard let context = context else {
            return
        }
        
        data.studiedWordCount = Int64(count)
        
        do {
            try context.save()
        } catch {
            print("코어데이터 업데이트 중 에러 \(error)")
        }
    }
    
    func calculateAttendanceRate(year: Int, month: Int, attendance: Int) -> Double {
        let days = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        var dayCount = days[month]
        if isLeapYear(year: year) && month == 2{
            dayCount = 28
        }
        return round(( Double(dayCount) / Double(attendance) ) * 100)
    }
    
    func isLeapYear(year: Int) -> Bool {
        if year % 400 == 0 {
            return true
        } else if year % 100 == 0 {
            return false
        } else if year % 4 == 0 {
            return true
        } else {
            return false
        }
    }
    
    func calculateStudyData(vocaDates: [VocaDate]) -> (studiedWords: Int, totalWords: Int, dailyRates: [Date: Double]) {
        
        var studiedWords = 0
        var totalWords = 0
        var dailyStudyRates: [Date: Double] = [:]
        
        for vocaDate in vocaDates {
            studiedWords += Int(vocaDate.studiedWordCount)
            totalWords += Int(vocaDate.totalWordCount)
            let rate = Double(vocaDate.studiedWordCount) / Double(vocaDate.totalWordCount)
            
            if let createdAt = vocaDate.createdAt {
                dailyStudyRates[createdAt] = rate
            }
        }
        
        return (studiedWords: studiedWords, totalWords: totalWords, dailyRates: dailyStudyRates)
    }
}
