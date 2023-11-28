//
//  RecipeListItemView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 15/11/2023.
//

import SwiftUI

struct RecipeListItemView: View {
    
//    var swipeLeft: (() -> ())
//    var swipeRight: (() -> ())
    
//    init(recipe: Binding<MyRecipes>) {
//        self.recipe = recipe
//    }
    
    var recipe: Binding<Recipe>
//    @State var isFavorited: Bool = false
    
    var body: some View {
        HStack {
            AsyncImage(url: recipe.wrappedValue.recipeImage) { image in
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
                Text("\(recipe.wrappedValue.recipeCategory!)")
                }
                .frame(maxWidth: 100, maxHeight: 100)
            Spacer()
            
            if recipe.wrappedValue.recipeIsFavorited == true {
                Image(systemName: "star.fill")
                    .padding(.horizontal)
                    .foregroundStyle(.yellow)
            }
            
//            Image(systemName: "chevron.right")
            
        }
        .padding(.vertical)
//        Divider()
    }
}

#Preview {
    RecipeListItemView(recipe: .constant(MyRecipes.demoRecipe))
}
