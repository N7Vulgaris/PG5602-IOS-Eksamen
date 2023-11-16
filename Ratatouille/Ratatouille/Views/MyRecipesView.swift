//
//  MyRecipesView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct MyRecipesView: View {
    
    init(savedRecipes: Binding<[MyRecipes]>, archivedRecipes: Binding<[MyRecipes]>) {
        self.savedRecipes = savedRecipes
        self.archivedRecipes = archivedRecipes
    }
    
    
    
    @State var savedRecipes: Binding<[MyRecipes]>
    @State var archivedRecipes: Binding<[MyRecipes]>
    
    func archiveRecipe(recipe: MyRecipes) {
//        var hasRemoved = false
    }
    
    func favoriteRecipe(recipe: Binding<MyRecipes>) {
        // TODO: get this shit working -> recipe.recipeIsFavorited = !recipe.recipeIsFavorited
        recipe.wrappedValue.recipeIsFavorited = !recipe.wrappedValue.recipeIsFavorited
        print(recipe.wrappedValue.recipeIsFavorited)
    }
    
    var body: some View {
        
        if savedRecipes.isEmpty {
            VStack {
                Image(systemName: "square.stack.3d.up.slash")
                    .scaleEffect(2.5)
                    .padding(.bottom)
                Text("Ingen matoppskrifter")
                    .font(.system(size: 25))
            }
        } else {
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
                            
//                            Button("Favoritt") {
//                                favoriteRecipe(reciepName: recipe.recipeName)
//                            }
//                            .tint(.yellow)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(action: {
                                archiveRecipe(recipe: recipe.wrappedValue)
                            }, label: {
                                Image(systemName: "xmark.bin.fill")
                                    .tint(.blue)
                            })
                        
//                            Button("Arkiver") {
//                                archiveRecipe(reciepName: recipe.recipeName)
//                            }
//                            .tint(.blue)
                        }
                }
            }
        }
    }
    
    
}

#Preview {
    MyRecipesView(savedRecipes: .constant([MyRecipes.init(id: 5, recipeName: "Kylling", recipeImage: "carrot.fill", recipeCategpry: "Dinner", recipeIsFavorited: true)]), archivedRecipes: .constant([
        MyRecipes.init(id: 99, recipeName: "Pølser", recipeImage: "carrot.fill", recipeCategpry: "Lunch", recipeIsFavorited: false)
    ]))
}
