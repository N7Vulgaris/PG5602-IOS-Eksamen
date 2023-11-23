//
//  MyRecipesView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct MyRecipesView: View {
    
    init(savedRecipes: Binding<[Recipe]>, archivedRecipes: Binding<MyRecipes>) {
        self.savedRecipes = savedRecipes
        self.archivedRecipes = archivedRecipes
    }
    
    // TODO: Figure out if I use @State or @Binding
    var savedRecipes: Binding<[Recipe]>
    var archivedRecipes: Binding<MyRecipes>
    
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
//        recipe.wrappedValue.recipeIsFavorited = !recipe.wrappedValue.recipeIsFavorited!
//        print(recipe.wrappedValue.recipeIsFavorited)
    }
    
    var body: some View {
        
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
            
            List {
                
                ForEach(savedRecipes) { recipe in
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
    }
    
    
}

#Preview {
    MyRecipesView(savedRecipes: .constant([Recipe]()), archivedRecipes: .constant(MyRecipes.demoRecipes))
}
