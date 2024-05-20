//
//  Voca+CoreDataProperties.swift
//  EveryDayVoca
//
//  Created by 배지해 on 5/20/24.
//
//

import Foundation
import CoreData


extension Voca {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Voca> {
        return NSFetchRequest<Voca>(entityName: "Voca")
    }

    @NSManaged public var english: String?
    @NSManaged public var korean: String?
    @NSManaged public var pronunciation: String?
    @NSManaged public var status: String?
    @NSManaged public var vocaDeck: String?

}

extension Voca : Identifiable {

}
