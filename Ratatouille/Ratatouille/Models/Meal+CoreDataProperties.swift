//
//  Meal+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Simen Hansen on 30/11/2023.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var imageUrl: String?
    @NSManaged public var name: String?
    @NSManaged public var isFavorited: Bool
    @NSManaged public var isArchived: Bool
    @NSManaged public var area: Area?
    @NSManaged public var category: Category?
    @NSManaged public var ingredient: NSSet?

}

// MARK: Generated accessors for ingredient
extension Meal {

    @objc(addIngredientObject:)
    @NSManaged public func addToIngredient(_ value: Ingredient)

    @objc(removeIngredientObject:)
    @NSManaged public func removeFromIngredient(_ value: Ingredient)

    @objc(addIngredient:)
    @NSManaged public func addToIngredient(_ values: NSSet)

    @objc(removeIngredient:)
    @NSManaged public func removeFromIngredient(_ values: NSSet)

}

extension Meal : Identifiable {

}
