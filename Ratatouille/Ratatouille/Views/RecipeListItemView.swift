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
            AsyncImage(url: recipe.wrappedValue.recipeImage, scale: 20) { image in
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
                Text("\(recipe.wrappedValue.recipeCategory)")
                }
            Spacer()
            
            if recipe.wrappedValue.recipeIsFavorited == true {
                Image(systemName: "star.fill")
                    .padding(.horizontal)
                    .foregroundStyle(.yellow)
            } else {
                Image(systemName: "star.fill")
                    .padding(.horizontal)
                    .foregroundStyle(.green)
            }
            
            Image(systemName: "chevron.right")
            
        }
        .padding(.vertical)
//        Divider()
    }
}

#Preview {
    RecipeListItemView(recipe: .constant(Recipe.init(recipeName: "Pizza", recipeImage: URL.init(string: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg"), recipeCategory: "Dinner", recipeIsFavorited: true)))
}
