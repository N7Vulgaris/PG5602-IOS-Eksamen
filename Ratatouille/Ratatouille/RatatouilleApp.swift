//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by Simen Hansen on 13/11/2023.
//

import SwiftUI
import CoreData

@main
struct RatatouilleApp: App {
    @State var splashCreenSsActive = true
    
//    @State var savedRecipes: MyRecipes = MyRecipes(recipes: [Recipe]())
    @State var savedRecipes = [Recipe]()
//    @State var savedRecipes = MyRecipes.demoRecipes
    @State var archivedRecipes = [Recipe]()
    
    @State var darkModeToggle: Bool = false
    
    @StateObject var dataController = DataController()
//    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var meals: FetchedResults<Meal>
    
    func retrieveDarkMode() {
        
        darkModeToggle = UserDefaults.standard.bool(forKey: "DarkModeToggle")
        
//        let defaults = UserDefaults.standard
//        
//        if case let isDarkModeOn as Bool = defaults.value(forKey: "DarkModeToggle") {
//            darkModeToggle = isDarkModeOn
//        } else {
//            return
//        }
    }
    
//    func getRecipesFromDb() {
//        
//        for meal in meals {
//            let newMeal = Recipe.init(recipeName: meal.name!, recipeImage: meal.imageUrl, recipeCategory: meal.category?.name, recipeArea: meal.area?.name, recipeInstructions: "", recipeIngredient1: "", recipeIngredient2: "", recipeIngredient3: "", recipeIsFavorited: false)
//            
//            savedRecipes.append(newMeal)
//        }
//        
//    }
    
    var body: some Scene {
        WindowGroup {
            
            if splashCreenSsActive {
                SplashScreenView(isActive: $splashCreenSsActive)
            } else {
                
                TabView {
                    MyRecipesView(savedRecipes: $savedRecipes, archivedRecipes: $archivedRecipes)
                        .tabItem {
                            Label("Mine oppskrifter", systemImage: "fork.knife.circle")
                        }
//                        .onAppear {
//                            let request = NSFetchRequest<Meal>(entityName: "Meal")
//                            var fetchedMeals = dataController.getMeals()
//                            
//                            for meal in fetchedMeals {
//                                print(meal.name)
//                            }
//                        }
                    
                    SearchView(savedRecipes: $savedRecipes)
                        .tabItem {
                            Label("Søk", systemImage: "magnifyingglass.circle")
                        }
                    
                    SettingsView(darkModeToggle: $darkModeToggle, savedRecipes: $savedRecipes, archivedRecipes: $archivedRecipes)
                        .tabItem {
                            Label("Innstillinger", systemImage: "gearshape.fill")
                        }
                }
                .onAppear {
                    retrieveDarkMode()
//                    getRecipesFromDb()
                }
                .preferredColorScheme(darkModeToggle ? .dark : .light)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                
            }
        }
    }
}
