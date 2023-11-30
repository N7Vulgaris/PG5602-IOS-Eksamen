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
    
    func archiveRecipe(recipe: Binding<Recipe>) {
        recipe.wrappedValue.recipeIsArchived = !recipe.wrappedValue.recipeIsArchived
        
        let requestedMeal = fetchMealByName(recipe: recipe)
        
        for meal in requestedMeal {
            meal.isArchived = recipe.wrappedValue.recipeIsArchived
        }
        
        moc.saveAndPrintError()
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
            let newMeal = Recipe.init(recipeName: meal.name!, recipeImage: meal.imageUrl, recipeCategory: meal.category?.name, recipeArea: meal.area?.name, recipeInstructions: "", recipeIngredient1: "", recipeIngredient2: "", recipeIngredient3: "", recipeIsFavorited: meal.isFavorited, recipeIsArchived: meal.isArchived)
            
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
                            if recipe.wrappedValue.recipeIsArchived == false {
                                //                                NavigationLink {
                                //
                                //                                } label: {
                                //                                    RecipeListItemView(recipe: recipe)
                                //                                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                //                                            Button(action: {
                                //                                                favoriteRecipe(recipe: recipe)
                                //                                            }, label: {
                                //                                                Image(systemName: "star.fill")
                                //                                                    .tint(.yellow)
                                //                                            })
                                //                                        }
                                //                                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                //                                            Button(action: {
                                //                                                archiveRecipe(recipe: recipe)
                                //                                            }, label: {
                                //                                                Image(systemName: "xmark.bin.fill")
                                //                                                    .tint(.blue)
                                //                                            })
                                //                                        }
                                //                                }
                                //                                .sheet(isPresented: $isPresentingUpdateView, content: {
                                //                                    UpdateRecipeView(recipe: recipe, isPresented: $isPresentingUpdateView)
                                //                                })
                                Button {
                                    isPresentingUpdateView = true
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
                                .sheet(isPresented: $isPresentingUpdateView, content: {
                                    UpdateRecipeView(recipe: recipe, isPresented: $isPresentingUpdateView)
                                })
                                
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
