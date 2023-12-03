//
//  UpdateRecipeView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 30/11/2023.
//

import SwiftUI
import CoreData

struct UpdateRecipeView: View {
    
    init(recipe: Binding<Recipe>) {
        self.recipe = recipe
//        self.refreshSavedRecipes = refreshSavedRecipes
    }
    
    let recipe: Binding<Recipe>
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedAreas: FetchedResults<Area>
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedCategories: FetchedResults<Category>
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedIngredients: FetchedResults<Ingredient>
    @Environment(\.dismiss) var dismiss
    
//    var refreshSavedRecipes: (() -> ())
    
    @State var newName: String = ""
    @State var newArea: String = ""
    @State var newCategory: String = ""
    @State var newIngredient: String = ""
    
    
    func fetchMealByName(recipe: Binding<Recipe>) -> [Meal] {
        
        let request = NSFetchRequest<Meal>(entityName: "Meal")
        let predicate = NSPredicate(format: "name == %@", recipe.wrappedValue.recipeName)
        request.predicate = predicate
        
        var requestedMeal = [Meal]()
        
        do {
            requestedMeal = try moc.fetch(request)
        } catch let error {
            print("Error fetching recipe from DB: \(error)")
        }
        return requestedMeal
    }
    
    func updateRecipe() {
        
        let requestedMeal = fetchMealByName(recipe: recipe)
        
        for meal in requestedMeal {
            meal.name = newName
            meal.area?.name = newArea
            meal.category?.name = newCategory
            meal.ingredient?.name = newIngredient
        }
        
        moc.saveAndPrintError()
        dismiss()
    }
    
    var body: some View {
        VStack {
            
            AsyncImage(url: URL.init(string: recipe.wrappedValue.recipeImage!)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 220)
            } placeholder: {
                Color.gray
            }
            .mask(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .padding()
            
                    
            Form {
                
                Section("Info") {
                    Text("Navn: \(recipe.wrappedValue.recipeName)")
                    Text("Område: \(recipe.wrappedValue.recipeArea ?? "")")
                    Text("Kategori: \(recipe.wrappedValue.recipeCategory ?? "")")
                    Text("Hoved ingredient: \(recipe.wrappedValue.recipeIngredient1 ?? "")")
                }
                
                NavigationStack {
                    Section {
                        NavigationLink {
                            ScrollView {
                                Text("\(recipe.wrappedValue.recipeInstructions ?? "Ingen instruksjoner tilgjengelig")")
                                    .padding()
                            }
                        } label: {
                            Text("Instruksjoner")
                        }
                    }
                }
                
                Section("Oppdater oppskrift") {
                    TextField("Navn...", text: $newName)
                    Menu {
                        ForEach(savedAreas) { area in
                            Button {
                                newArea = area.name!
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
                            } label: {
                                Text("\(category.name!)")
                            }
                        }
                    } label: {
                        Text("Kategori")
                    }
                    Menu {
                        ForEach(savedIngredients) { ingredient in
                            Button {
                                newIngredient = ingredient.name!
                            } label: {
                                Text("\(ingredient.name!)")
                            }
                        }
                    } label: {
                        Text("Ingredienser")
                    }
                }
                Button {
                    updateRecipe()
                } label: {
                    Text("Lagre")
                }
            }
            
        }
        .onAppear {
            newName = recipe.wrappedValue.recipeName
            newArea = recipe.wrappedValue.recipeArea ?? ""
            newCategory = recipe.wrappedValue.recipeCategory ?? ""
            newIngredient = recipe.wrappedValue.recipeIngredient1 ?? ""
        }
        .onDisappear {
            moc.refreshAllObjects()
        }
    }
}

#Preview {
    UpdateRecipeView(recipe: .constant(MyRecipes.demoRecipe))
}
