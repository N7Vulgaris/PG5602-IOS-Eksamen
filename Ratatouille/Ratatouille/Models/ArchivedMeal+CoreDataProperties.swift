//
//  ArchivedMeal+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Simen Hansen on 03/12/2023.
//
//

import Foundation
import CoreData


extension ArchivedMeal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArchivedMeal> {
        return NSFetchRequest<ArchivedMeal>(entityName: "ArchivedMeal")
    }

    @NSManaged public var area: String?
    @NSManaged public var category: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var ingredient: String?
    @NSManaged public var isFavorited: Bool
    @NSManaged public var name: String?
    @NSManaged public var instructions: String?

}

extension ArchivedMeal : Identifiable {

}
