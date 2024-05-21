//
//  VocaDeck+CoreDataProperties.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/21/24.
//
//

import Foundation
import CoreData


extension VocaDeck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VocaDeck> {
        return NSFetchRequest<VocaDeck>(entityName: "VocaDeck")
    }

    @NSManaged public var count: Int64
    @NSManaged public var name: String?
    @NSManaged public var vocaDeck: NSSet?

}

// MARK: Generated accessors for vocaDeck
extension VocaDeck {

    @objc(addVocaDeckObject:)
    @NSManaged public func addToVocaDeck(_ value: Voca)

    @objc(removeVocaDeckObject:)
    @NSManaged public func removeFromVocaDeck(_ value: Voca)

    @objc(addVocaDeck:)
    @NSManaged public func addToVocaDeck(_ values: NSSet)

    @objc(removeVocaDeck:)
    @NSManaged public func removeFromVocaDeck(_ values: NSSet)

}

extension VocaDeck : Identifiable {

}
