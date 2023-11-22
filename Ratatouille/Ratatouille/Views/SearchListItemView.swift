//
//  SearchListItemView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 22/11/2023.
//

import SwiftUI

struct SearchListItemView: View {
    
    @State var recipe: Recipe
    
    var body: some View {
        
        HStack {
//                Image(systemName: recipe.wrappedValue.recipeImage)
//            AsyncImage(url: recipe.wrappedValue.recipeImage)
//                .mask(Circle())
//                .scaledToFit()
//                .frame(width: 60)
            
            AsyncImage(url: recipe.recipeImage, scale: 20) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Color.gray
            }
            .frame(width: 60)
            .mask(Circle())

            
            VStack(alignment: .leading) {
                Text("\(recipe.recipeName)")
                Text("\(recipe.recipeCategory)")
                }
            Spacer()
            
            if recipe.recipeIsFavorited == true {
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
    }
}

#Preview {
    SearchListItemView(recipe: Recipe.init(recipeName: "Tacos", recipeImage: URL.init(string: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg"), recipeCategory: "Dinner", recipeIsFavorited: true))
}
