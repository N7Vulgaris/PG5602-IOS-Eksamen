//
//  SearchListItemView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 22/11/2023.
//

import SwiftUI

struct SearchListItemView: View {
    
    init(recipe: Binding<Recipe>) {
        self.recipe = recipe
//        self.swipedLeft = swipedLeft
//        self.swipedRight = swipedRight
    }
    
    var recipe: Binding<Recipe>
    
//    var swipedLeft: (() -> Void)
//    var swipedRight: (() -> Void)
    
    var body: some View {
        
        HStack {
//                Image(systemName: recipe.wrappedValue.recipeImage)
//            AsyncImage(url: recipe.wrappedValue.recipeImage)
//                .mask(Circle())
//                .scaledToFit()
//                .frame(width: 60)
            
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
            
//            if recipe.wrappedValue.recipeIsFavorited == true {
//                Image(systemName: "star.fill")
//                    .padding(.horizontal)
//                    .foregroundStyle(.yellow)
//            }
            
            Image(systemName: "chevron.right")
            
        }
        .padding(.vertical)
    }
}

#Preview {
    SearchListItemView(recipe: .constant(MyRecipes.demoRecipe))
}
