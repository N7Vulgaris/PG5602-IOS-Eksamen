//
//  MyRecipesView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct MyRecipesView: View {
    
    init(savedRecipes: Binding<[Recipe]>, archivedRecipes: Binding<[Recipe]>) {
        self.savedRecipes = savedRecipes
        self.archivedRecipes = archivedRecipes
    }
    
    // TODO: Figure out if I use @State or @Binding
    var savedRecipes: Binding<[Recipe]>
    var archivedRecipes: Binding<[Recipe]>
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var meals: FetchedResults<Meal>
    
    func archiveRecipe(recipe: Binding<Recipe>) {
        // TODO: ALSO get this shit working:
        var hasRemoved = false
        
//        archivedRecipes.wrappedValue.append(recipe.wrappedValue)
//        savedRecipes.wrappedValue.removeAll { filteredRecipe in
//            if filteredRecipe.recipeName == recipe.wrappedValue.recipeName, hasRemoved == false {
//                hasRemoved = true
//                print("delete")
//                return true
//            }
//            print("no delte")
//            return false
//        }
    }
    
    func favoriteRecipe(recipe: Binding<Recipe>) {
        // TODO: get this shit working -> recipe.recipeIsFavorited = !recipe.recipeIsFavorited
        recipe.wrappedValue.recipeIsFavorited = !recipe.wrappedValue.recipeIsFavorited
        
    }
    
    func getRecipesFromDb() {
        
        for meal in meals {
            let newMeal = Recipe.init(recipeName: meal.name!, recipeImage: meal.imageUrl, recipeCategory: meal.category?.name, recipeArea: meal.area?.name, recipeInstructions: "", recipeIngredient1: "", recipeIngredient2: "", recipeIngredient3: "", recipeIsFavorited: false)
            // TODO: Add recipeIsFavorited as an attribute in the DB
            
            
            if !savedRecipes.wrappedValue.contains(where: { $0.recipeName == newMeal.recipeName }) {
                savedRecipes.wrappedValue.append(newMeal)
            }
        }
    }
    
    var body: some View {
        VStack {
//            Text("Ratatouille")
//            Spacer()
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
                                //                            RecipeDetailView(recipe: recipe)
                                // TODO: Add RecipeEditView here
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
                        }
                    }
                    .navigationTitle("Matoppskrifter")
                }
            }
        }
        .onAppear {
            getRecipesFromDb()
        }
    }
    
    
}

#Preview {
    MyRecipesView(savedRecipes: .constant(MyRecipes.demoRecipes), archivedRecipes: .constant(MyRecipes.demoRecipes))
}
