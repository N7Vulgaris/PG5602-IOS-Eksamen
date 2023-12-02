//
//  UpdateRecipeView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 30/11/2023.
//

import SwiftUI
import CoreData

struct UpdateRecipeView: View {
    
    init(recipe: Binding<Recipe>, refreshSavedRecipes: @escaping (() -> ())) {
        self.recipe = recipe
        self.refreshSavedRecipes = refreshSavedRecipes
//        self.isPresented = isPresented
    }
    
    let recipe: Binding<Recipe>
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedAreas: FetchedResults<Area>
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedCategories: FetchedResults<Category>
//    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedMeals: FetchedResults<Meal>
    
//    var isPresented: Binding<Bool>
    @Environment(\.dismiss) var dismiss
    
    var refreshSavedRecipes: (() -> ())
    
    @State var newName: String = ""
    @State var newArea: String = ""
    @State var newCategory: String = ""
    @State var newIngredients: [String] = []
    
    
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
    
    func updateRecipe() {
        
        let requestedMeal = fetchMealByName(recipe: recipe)
        
        for meal in requestedMeal {
            meal.name = newName
            meal.area?.name = newArea
            meal.category?.name = newCategory
        }
        
        moc.saveAndPrintError()
        
//        isPresented.wrappedValue = false
        refreshSavedRecipes()
        dismiss()
    }
    
    var body: some View {
        VStack {
            
            AsyncImage(url: URL.init(string: recipe.wrappedValue.recipeImage!)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300)
            } placeholder: {
                Color.gray
            }
            .mask(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .padding()
            
                    
            Form {
                Section("Oppdater oppskrift") {
                    TextField("Navn...", text: $newName)
                    Menu {
                        ForEach(savedAreas) { area in
                            Button {
                                newArea = area.name!
                                print(newArea)
                            } label: {
                                Text("\(area.name!)")
                            }
                        }
                    } label: {
                        Text("Område")
                    }
                    Menu {
                        ForEach(savedCategories) { category in
                            Button {
                                newCategory = category.name!
                                print(newCategory)
                            } label: {
                                Text("\(category.name!)")
                            }
                        }

                    } label: {
                        Text("Kategori")
                    }
//                    TextField("Område...", text: $newArea)
//                    TextField("Kategori...", text: $newCategory)
                }
                
                //            Section("Ingredienser") {
                //                ForEach(newIngredients) { ingredient in
                //                    TextField("", text: ingredient)
                //                }
                //            }
                
                Button {
                    updateRecipe()
                } label: {
                    Text("Lagre")
                }
            }
            
        }
        .onAppear {
            newName = recipe.wrappedValue.recipeName
            newArea = recipe.wrappedValue.recipeArea!
            newCategory = recipe.wrappedValue.recipeCategory!
            newIngredients = [recipe.wrappedValue.recipeIngredient1!,
                              recipe.wrappedValue.recipeIngredient2!,
                              recipe.wrappedValue.recipeIngredient3!]
        }
        .onDisappear {
            moc.refreshAllObjects()
        }
    }
}

#Preview {
    UpdateRecipeView(recipe: .constant(MyRecipes.demoRecipe)) {
        print("Refresh")
    }
}
