//
//  DataController.swift
//  Ratatouille
//
//  Created by Simen Hansen on 29/11/2023.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "RecipesDB")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error)")
            }
        }
    }
    
    func getMeals() -> [Meal] {
        
        let request = NSFetchRequest<Meal>(entityName: "Meal")
        var fetchedMeals = [Meal]()
        
        do {
            fetchedMeals = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching: \(error)")
        }
        return fetchedMeals
    }    
}

extension NSManagedObjectContext {
    func saveAndPrintError() {
        do {
            try self.save()
        } catch let error {
            print(error)
        }
    }
}

