//
//  ManageArchiveView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 01/12/2023.
//

import SwiftUI
import CoreData

struct ManageArchiveView: View {
    
    init(savedRecipes: Binding<[Recipe]>, archivedRecipes: Binding<[Recipe]>) {
        self.savedRecipes = savedRecipes
        self.archivedRecipes = archivedRecipes
    }
    
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedMeals: FetchedResults<Meal>
//    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var archivedMeals: FetchedResults<ArchivedMeal>
    
    var savedRecipes: Binding<[Recipe]>
    var archivedRecipes: Binding<[Recipe]>
    
    
    func deleteMeal(mealToDelete: Binding<Recipe>) {
        
        let requestedMeal = fetchMealByName(recipe: mealToDelete)
        
        for meal in requestedMeal {
            moc.delete(meal)
        }
        moc.saveAndPrintError()
    }
    
    func restoreMeal(mealToRestore: Binding<Recipe>) {
        
        let requestedMeal = fetchMealByName(recipe: mealToRestore)
        
        // Add to saved DB
        let entity = NSEntityDescription.entity(forEntityName: "Meal", in: moc)!
        // Remove from archive DB
        for meal in requestedMeal {
            
//            print(meal.name)
            
            let newMeal = Meal(entity: entity, insertInto: moc)
            newMeal.name = meal.name
            newMeal.area?.name = meal.area
            newMeal.category?.name = meal.category
            newMeal.imageUrl = meal.imageUrl
            newMeal.isFavorited = meal.isFavorited
            moc.delete(meal)
        }
        
        
        moc.saveAndPrintError()
    
        var hasRemoved = false
        // Add to archive array
        savedRecipes.wrappedValue.append(mealToRestore.wrappedValue)
        // Remove from saved array
        archivedRecipes.wrappedValue.removeAll { recipeToRemove in
            if recipeToRemove.recipeName == mealToRestore.wrappedValue.recipeName, hasRemoved == false {
                hasRemoved = true
                return true
            }
            return false
        }
    }
    
    func fetchMealByName(recipe: Binding<Recipe>) -> [ArchivedMeal] {
        
        let request = NSFetchRequest<ArchivedMeal>(entityName: "ArchivedMeal")
        //        let name = recipe.wrappedValue.recipeName
        let predicate = NSPredicate(format: "name == %@", recipe.wrappedValue.recipeName)
        request.predicate = predicate
        
        var requestedMeal = [ArchivedMeal]()
        
        do {
            requestedMeal = try moc.fetch(request)
        } catch let error {
            print(error)
        }
        
        return requestedMeal
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(archivedRecipes) { recipe in
                    HStack {
                        AsyncImage(url: URL.init(string: recipe.wrappedValue.recipeImage ?? "")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 60)
                        .mask(Circle())
                        Text("\(recipe.wrappedValue.recipeName)")
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(action: {
                            deleteMeal(mealToDelete: recipe)
                        }, label: {
                            Image(systemName: "trash")
                                .tint(.red)
                        })
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(action: {
                            restoreMeal(mealToRestore: recipe)
                        }, label: {
                            Image(systemName: "tray.and.arrow.up.fill")
                                .tint(.gray)
                        })
                    }

                    
                }
            }
            
        }
    }
}

#Preview {
    ManageArchiveView(savedRecipes: .constant(MyRecipes.demoRecipes), archivedRecipes: .constant(MyRecipes.demoRecipes))
}
