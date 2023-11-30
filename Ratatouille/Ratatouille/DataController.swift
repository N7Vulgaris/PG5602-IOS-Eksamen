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
            print(description) // <- DB filepath
        }
//        getMeals()
    }
    
//    static let shared = DataController()
    
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
    
//    func addMeal() {
//        
//        let newMeal = Meal(context: container.viewContext)
//        newMeal.category?.name = ""
//        
//        saveData()
//        
//    }
//    
//    func saveData() {
//        do {
//            try container.viewContext.save()
//        } catch let error {
//            print("Error saving: \(error)")
//        }
//    }
    
}
