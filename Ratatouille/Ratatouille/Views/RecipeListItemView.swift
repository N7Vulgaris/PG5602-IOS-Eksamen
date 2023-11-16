//
//  RecipeListItemView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 15/11/2023.
//

import SwiftUI

struct RecipeListItemView: View {
    
    var recipe: MyRecipes
    @State var isFavorited: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                Circle().fill(.blue.gradient) // TODO: Maybe make function to generate random color
                    .scaledToFit()
                    .frame(width: 60)
                Image(systemName: recipe.recipeImage)
            }
            VStack(alignment: .leading) {
                    Text("\(recipe.recipeName)")
                    Text("\(recipe.recipeCategpry)")
                }
            Spacer()
            
            if isFavorited {
                Image(systemName: "star.fill")
                    .padding(.horizontal)
            }
            
            Image(systemName: "chevron.right")
            
        }
        .padding(.vertical)
//        Divider()
    }
}

#Preview {
    RecipeListItemView(recipe: MyRecipes(id: 4, recipeName: "Pannekaker", recipeImage: "carrot.fill", recipeCategpry: "Breakfast"))
}
