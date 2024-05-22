//
//  VocaDate+CoreDataProperties.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/21/24.
//
//

import Foundation
import CoreData


extension VocaDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VocaDate> {
        return NSFetchRequest<VocaDate>(entityName: "VocaDate")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var studiedWordCount: Int64
    @NSManaged public var leadWordIndex: Int64
    @NSManaged public var totalWordCount: Int64

}

extension VocaDate : Identifiable {

}
