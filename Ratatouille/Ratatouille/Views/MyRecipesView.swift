//
//  MyRecipesView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct MyRecipesView: View {
    
    @State var myRecipes: [MyRecipes]
    
    func archiveRecipe(reciepName: String) {
        print("Archive \(reciepName)!")
    }
    
    func favoriteRecipe(reciepName: String) {
        print("Favorite \(reciepName)!")
    }
    
    var body: some View {
        
        if myRecipes.isEmpty {
            VStack {
                Image(systemName: "square.stack.3d.up.slash")
                    .scaleEffect(2.5)
                    .padding(.bottom)
                Text("Ingen matoppskrifter")
                    .font(.system(size: 25))
            }
        } else {
            List {
                ForEach(myRecipes) { recipe in
                    RecipeListItemView(recipe: recipe)
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button("Favoritt") {
                                favoriteRecipe(reciepName: recipe.recipeName)
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button("Arkiver") {
                                archiveRecipe(reciepName: recipe.recipeName)
                            }
                            .tint(.blue)
                        }
                }
            }
        }
    }
    
    
}

#Preview {
    MyRecipesView(myRecipes: MyRecipes.demoRecipes)
}
