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
    }
    
    var recipe: Binding<Recipe>
    
    var body: some View {
        
        HStack {
            AsyncImage(url: URL.init(string: recipe.wrappedValue.recipeImage!) , scale: 20) { image in
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
                Text("\(recipe.wrappedValue.recipeCategory!)")
                }
            Spacer()
            
//            if recipe.wrappedValue.recipeIsFavorited == true {
//                Image(systemName: "star.fill")
//                    .padding(.horizontal)
//                    .foregroundStyle(.yellow)
//            }
            
        }
        .padding(.vertical)
    }
}

#Preview {
    SearchListItemView(recipe: .constant(MyRecipes.demoRecipe))
}
