//
//  RecipeListItemView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 15/11/2023.
//

import SwiftUI

struct RecipeListItemView: View {
    
    init(recipe: Binding<Recipe>) {
        self.recipe = recipe
    }
    
    var recipe: Binding<Recipe>
    
    var body: some View {
        HStack {
            AsyncImage(url: URL.init(string: recipe.wrappedValue.recipeImage!)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            .frame(width: 60)
            .mask(Circle())
            
            
            
            VStack(alignment: .leading) {
                Text("\(recipe.wrappedValue.recipeName)")
                Divider()
                Text("\(recipe.wrappedValue.recipeCategory ?? "")")
                }
                .frame(maxWidth: 150, maxHeight: 90)
            Spacer()
            
            if recipe.wrappedValue.recipeIsFavorited == true {
                Image(systemName: "star.fill")
                    .padding(.horizontal)
                    .foregroundStyle(.yellow)
            }
        }
        .padding(.vertical)
//        Divider()
    }
}

#Preview {
    RecipeListItemView(recipe: .constant(MyRecipes.demoRecipe))
}
