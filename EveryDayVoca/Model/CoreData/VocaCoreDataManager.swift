//
//  VocaCoreDataManager.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/20/24.
//

import Foundation
import UIKit
import CoreData

final class VocaCoreDataManager {
    
    static let shared = VocaCoreDataManager()
    private init() {}
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    private let vocaDeckModel: String = "VocaDeck"
    private let vocaModel: String = "Voca"
    private let dateModel: String = "VocaDate"
    
    let cardDeckData: [String: Int] = [ "ALL": 5968, "기초": 800, "중등": 1800, "고등": 400, "토익": 1222, "1": 288, "2": 600, "3": 388, "4": 135, "5": 335]
    
    // MARK: - .csv => CoreData
    
    private func isFirstLaunch() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: "지해지해님")
        if launchedBefore {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: "지해지해님")
            return true
        }
    }
    
    func importCSVDataIfNeeded(fileName: String) {
        guard isFirstLaunch() else { return }
        
        guard let csvPath = Bundle.main.path(forResource: fileName, ofType: "csv"),
              let data = try? String(contentsOfFile: csvPath, encoding: .utf8) else {
            print("csv File 로딩 중 에러")
            return
        }
        
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: vocaModel, in: context) else {
            return
        }
        
        let rows = data.components(separatedBy: "\n").filter{ !$0.isEmpty }
        
        for row in rows {
            let columns = row.components(separatedBy: ",")
            if columns.count >= 4 {
                guard let num = Int64(columns[3].trimmingCharacters(in: .whitespacesAndNewlines)) else {
                    continue
                }
                let newData = Voca(entity: entity, insertInto: context)
                newData.english = columns[0]
                newData.korean = columns[1]
                newData.status = "미학습"
                newData.vocaDeck = columns[2]
                newData.index = num
            } else {
                print("넘어간 Row 값 : \(row)")
            }
        }
        
        do {
            try context.save()
            print("코어데이터 저장 성공")
        } catch {
            print("코어데이터 저장 실패 \(error)")
        }
        
        createVocaDeckData(cardDeckData)
    }
    
    
    // MARK: - Voca CoreData
    
    func createVocaData(english: String, korean: String, vocaDeck: String) {
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: vocaModel, in: context) else {
            return
        }
        
        let newData = Voca(entity: entity, insertInto: context)
        
        newData.english = english
        newData.korean = korean
        newData.status = "미학습"
        newData.vocaDeck = vocaDeck
        
        do {
            try context.save()
            print("코어데이터 저장 성공")
        } catch {
            print("코어데이터 저장 중 에러 \(error)")
        }
    }
    
    // 삭제할 가능성 있음
    func getVocaData() -> [Voca] {
        var vocaList = [Voca]()
        
        guard let context = context else {
            return vocaList
        }
        
        let fetchRequest: NSFetchRequest<Voca> = Voca.fetchRequest()
        
        do {
            vocaList = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        return vocaList
    }
    
    // 삭제할 가능성 있음
    func getVocaData(forvocaDeck vocaDeck: String) -> [Voca] {
        var vocaList = [Voca]()
        
        guard let context = context else {
            return vocaList
        }
        
        let fetchRequest: NSFetchRequest<Voca> = Voca.fetchRequest()
        
        let predicate = NSPredicate(format: "vocaDeck == %@", vocaDeck)
        fetchRequest.predicate = predicate
        
        do {
            vocaList = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        return vocaList
    }
    
    func getVocaData(forvocaDeck vocaDeck: String, status: Status) -> [Voca] {
        var vocaList = [Voca]()
        
        guard let context = context else {
            return vocaList
        }
        
        let fetchRequest: NSFetchRequest<Voca> = Voca.fetchRequest()
        
        if vocaDeck != "ALL" {
            let predicate = NSPredicate(format: "vocaDeck == %@ AND status == %@", vocaDeck, status.rawValue)
            fetchRequest.predicate = predicate
        }else {
            let predicate = NSPredicate(format: "status == %@", status.rawValue)
            fetchRequest.predicate = predicate
        }
        
        do {
            vocaList = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        return vocaList
    }
    
    func getVocaDataWithIndex(firstIndex: Int, count: Int) -> [Voca] {
        var vocaList = [Voca]()
        
        guard let context = context else {
            return vocaList
        }
        
        let fetchRequest: NSFetchRequest<Voca> = Voca.fetchRequest()
        
        let endIndex = firstIndex + count - 1
        let predicate = NSPredicate(format: "index BETWEEN {%lld, %lld}", Int64(firstIndex), Int64(endIndex))
        fetchRequest.predicate = predicate
        
        do {
            vocaList = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        return vocaList
    }
    
    func calculateMemorizedWordCountByLevel(level: Int) -> Int {
        var vocaList = [Voca]()
        
        guard let context = context else {
            return 0
        }
        
        let fetchRequest: NSFetchRequest<Voca> = Voca.fetchRequest()
        
        let predicate = NSPredicate(format: "vocaDeck == %@ AND status == %@", String(level), Status.memorized.rawValue)
        fetchRequest.predicate = predicate
        
        do {
            vocaList = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        print(vocaList)
        
        return vocaList.count
    }
    
    func updateVocaStatus(_ vocaData: Voca, status: Status) {
        guard let context = context else {
            return
        }
        vocaData.status = status.rawValue
        do {
            try context.save()
        } catch {
            print("코어데이터 업데이트 중 에러 \(error)")
        }
    }
    
    func getStudyData(index: Int, count: Int) -> [Status: Int] {
        
        let vocaData = getVocaDataWithIndex(firstIndex: index, count: count)
        
        var studyData: [Status: Int] = [.memorized: 0, .ambiguous: 0, .difficult: 0, .none: 0]
        
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
              let entity = NSEntityDescription.entity(forEntityName: vocaDeckModel, in: context) else {
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
    
    func createVocaDeckData(_ vocaDeckData: [String:Int]) {
        guard let context = context,
              let entity = NSEntityDescription.entity(forEntityName: vocaDeckModel, in: context) else {
            return
        }
        
        for data in vocaDeckData {
            let newData = VocaDeck(entity: entity, insertInto: context)
            
            newData.name = data.key
            newData.count = Int64(data.value)
            
            do {
                try context.save()
                print("코어데이터 저장 성공")
            } catch {
                print("코어데이터 저장 중 에러 \(error)")
            }
        }
    }
    
    func getVocaDeckData() -> [VocaDeck] {
        var vocaDeckList = [VocaDeck]()
        
        guard let context = context else {
            return vocaDeckList
        }
        
        let fetchRequest: NSFetchRequest<VocaDeck> = VocaDeck.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false, selector: #selector(NSString.localizedStandardCompare(_:)))
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            vocaDeckList = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        return vocaDeckList
    }
    
    func updateVocaDeckCount(_ vocaDeck: String) {
        var vocaDecks = [VocaDeck]()
        
        guard let context = context else {
            return
        }
        
        let fetchRequest: NSFetchRequest<VocaDeck> = VocaDeck.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", vocaDeck)
        fetchRequest.predicate = predicate
        
        do {
            vocaDecks = try context.fetch(fetchRequest)
        } catch {
            print("코어데이터 가져오는 중 에러 \(error)")
        }
        
        vocaDecks[0].count += 1
        
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
        
        let calender = Calendar.current
        let starOfDay = calender.startOfDay(for: date)
        
        var dateComponents = DateComponents()
        dateComponents.day = 1
        let endOfDay = calender.date(byAdding: dateComponents, to: starOfDay)!
        
        let predicate = NSPredicate(format: "(createdAt >= %@) AND (createdAt < %@)", starOfDay as NSDate, endOfDay as NSDate)
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
        
        guard let context = context else {
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
            print("데이터 가져오는 중 에러 : \(error)")
        }
        
        return vocaDateData
    }
    
    func getVocaDate() -> [VocaDate] {
        
        var vocaDateData = [VocaDate]()
        
        guard let context = context else {
            return vocaDateData
        }
        
        let fetchRequest: NSFetchRequest<VocaDate> = VocaDate.fetchRequest()
        
        do {
            vocaDateData = try context.fetch(fetchRequest)
        } catch {
            print("데이터 가져오는 중 에러 : \(error)")
        }
        
        return vocaDateData
    }
    
    func updateVocaDateStudiedWordCount(_ date: VocaDate, isPlus: Bool) {
        guard let context = context else { return }
        
        if isPlus {
            date.studiedWordCount += 1
        }else {
            date.studiedWordCount -= 1
        }
        
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
        return round(( Double(attendance) / Double(dayCount) ) * 100)
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
    
    func calculateStudyData(vocaDates: [VocaDate]) -> (studiedWords: Int, totalWords: Int, dailyRates: [String: Double]) {
        var studiedWords = 0
        var totalWords = 0
        var dailyStudyRates: [String: Double] = [:]
        for vocaDate in vocaDates {
            studiedWords += Int(vocaDate.studiedWordCount)
            totalWords += Int(vocaDate.totalWordCount)
            let rate = Double(vocaDate.studiedWordCount) / Double(vocaDate.totalWordCount)
            if let createdAt = vocaDate.createdAt {
                let dateStr = formatDateToString(createdAt)
                dailyStudyRates[dateStr] = rate
            }
        }
        return (studiedWords: studiedWords, totalWords: totalWords, dailyRates: dailyStudyRates)
    }
    
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func dateComponentsToString(_ components: DateComponents) -> String? {
        if let date = Calendar.current.date(from: components) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: date)
            return dateString
        }
        return nil
    }
    
    func calculateMonthlyStudyData(vocaDates: [VocaDate]) -> [Status: Int] {
        
        var studyData: [Status: Int] = [.memorized: 0, .ambiguous: 0, .difficult: 0]
        
        for date in vocaDates {
            let vocaData = getVocaDataWithIndex(firstIndex: Int(date.leadWordIndex), count: Int(date.totalWordCount))
            for data in vocaData {
                switch data.status {
                case "외웠어요":
                    studyData[.memorized]! += 1
                case "애매해요":
                    studyData[.ambiguous]! += 1
                case "어려워요":
                    studyData[.difficult]! += 1
                default:
                    continue
                }
            }
        }
        
        return studyData
    }
}
