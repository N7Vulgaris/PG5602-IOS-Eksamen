//
//  MyRecipesView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI
import CoreData

struct MyRecipesView: View {
    
    init(savedRecipes: Binding<[Recipe]>, archivedRecipes: Binding<[Recipe]>) {
        self.savedRecipes = savedRecipes
        self.archivedRecipes = archivedRecipes
    }
    
    // TODO: Figure out if I use @State or @Binding
    var savedRecipes: Binding<[Recipe]>
    var archivedRecipes: Binding<[Recipe]>
    
    @State var isPresentingUpdateView: Bool = false
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedMeals: FetchedResults<Meal>
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var archivedMeals: FetchedResults<ArchivedMeal>
    
    func archiveRecipe(recipe: Binding<Recipe>) {
        
        let requestedMeal = fetchMealByName(recipe: recipe)
        // Add to archive DB
        let entity = NSEntityDescription.entity(forEntityName: "ArchivedMeal", in: moc)!
        // Remove from saved DB
        for meal in requestedMeal {
            
            let mealToArchive = ArchivedMeal(entity: entity, insertInto: moc)
            mealToArchive.name = meal.name
            mealToArchive.area = meal.area?.name
            mealToArchive.category = meal.category?.name
            mealToArchive.imageUrl = meal.imageUrl
            mealToArchive.isFavorited = meal.isFavorited
            
            moc.delete(meal)
        }
        
        moc.saveAndPrintError()
    
        var hasRemoved = false
        // Add to archive array
        archivedRecipes.wrappedValue.append(recipe.wrappedValue)
        // Remove from saved array
        savedRecipes.wrappedValue.removeAll { recipeToRemove in
            if recipeToRemove.recipeName == recipe.wrappedValue.recipeName, hasRemoved == false {
                hasRemoved = true
                return true
            }
            return false
        }
    }
    
    func favoriteRecipe(recipe: Binding<Recipe>) {
        recipe.wrappedValue.recipeIsFavorited = !recipe.wrappedValue.recipeIsFavorited
        
        let requestedMeal = fetchMealByName(recipe: recipe)
        
        for meal in requestedMeal {
            meal.isFavorited = recipe.wrappedValue.recipeIsFavorited
        }
        
        moc.saveAndPrintError()
        
    }
    
    func fetchMealByName(recipe: Binding<Recipe>) -> [Meal] {
        
        let request = NSFetchRequest<Meal>(entityName: "Meal")
        //        let name = recipe.wrappedValue.recipeName
        let predicate = NSPredicate(format: "name == %@", recipe.wrappedValue.recipeName)
        request.predicate = predicate
        
        var requestedMeal = [Meal]()
        
        do {
            requestedMeal = try moc.fetch(request)
        } catch let error {
            print(error)
        }
        return requestedMeal
    }
    
    func getRecipesFromDb() {
        for meal in savedMeals {
            let newMeal = Recipe.init(recipeName: meal.name!, recipeImage: meal.imageUrl, recipeCategory: meal.category?.name, recipeArea: meal.area?.name, recipeInstructions: "", recipeIngredient1: "", recipeIngredient2: "", recipeIngredient3: "", recipeIsFavorited: meal.isFavorited)
            
            if !savedRecipes.wrappedValue.contains(where: { $0.recipeName == newMeal.recipeName }) {
                savedRecipes.wrappedValue.append(newMeal)
            }
        }
    }
    
    func getArchiveFromDb() {
        for meal in archivedMeals {
//            let newMeal = Recipe.init(recipeName: meal.name!, recipeImage: meal.imageUrl, recipeCategory: meal.category?.name, recipeArea: meal.area?.name, recipeInstructions: "", recipeIngredient1: "", recipeIngredient2: "", recipeIngredient3: "", recipeIsFavorited: meal.isFavorited)
            
            let newMeal = Recipe.init(recipeName: meal.name ?? "", recipeImage: meal.imageUrl, recipeCategory: meal.category, recipeArea: meal.area, recipeInstructions: "", recipeIngredient1: "", recipeIngredient2: "", recipeIngredient3: "", recipeIsFavorited: meal.isFavorited)
            
            if !archivedRecipes.wrappedValue.contains(where: { $0.recipeName == newMeal.recipeName }) {
                archivedRecipes.wrappedValue.append(newMeal)
            }
        }
    }
    
//    func deleteAllDB() {
//        for meal in savedMeals {
//            moc.delete(meal)
//        }
//        for meal in archivedMeals {
//            moc.delete(meal)
//        }
//        moc.saveAndPrintError()
//    }
    
    var body: some View {
        VStack {
            //            Text("Ratatouille")
            //            Spacer()
            Button {
//                deleteAllDB()
            } label: {
                Text("Delete all")
            }
            
            if savedRecipes.wrappedValue.isEmpty {
                VStack {
                    Image(systemName: "square.stack.3d.up.slash")
                        .scaleEffect(2.5)
                        .padding(.bottom)
                    Text("Ingen matoppskrifter")
                        .font(.system(size: 25))
                }
            } else {
                
                // TODO: Add NavigationStack and NavigationLinks for RecipeDetailView
                
                NavigationStack {
                    List {
                        ForEach(savedRecipes) { recipe in
                                NavigationLink {
//                                    isPresentingUpdateView = true
                                    UpdateRecipeView(recipe: recipe)
                                } label: {
                                    RecipeListItemView(recipe: recipe)
                                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                            Button(action: {
                                                favoriteRecipe(recipe: recipe)
                                            }, label: {
                                                Image(systemName: "star.fill")
                                                    .tint(.yellow)
                                            })
                                        }
                                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                            Button(action: {
                                                archiveRecipe(recipe: recipe)
                                            }, label: {
                                                Image(systemName: "xmark.bin.fill")
                                                    .tint(.blue)
                                            })
                                        }
                                }
//                                .sheet(isPresented: $isPresentingUpdateView) {
//                                    UpdateRecipeView(recipe: recipe, isPresented: $isPresentingUpdateView)
//                                }
                                
                        }
                    }
                    .navigationTitle("Matoppskrifter")
                }
            }
        }
        .onAppear {
            getRecipesFromDb()
            getArchiveFromDb()
        }
    }
    
    
}

#Preview {
    MyRecipesView(savedRecipes: .constant(MyRecipes.demoRecipes), archivedRecipes: .constant(MyRecipes.demoRecipes))
}
