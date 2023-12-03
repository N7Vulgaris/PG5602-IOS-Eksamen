//
//  Meal+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Simen Hansen on 03/12/2023.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var isFavorited: Bool
    @NSManaged public var name: String?
    @NSManaged public var area: Area?
    @NSManaged public var category: Category?
    @NSManaged public var ingredient: Ingredient?

}

extension Meal : Identifiable {

}
