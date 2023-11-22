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
    
    @State var recipe: Binding<MyRecipes>
//    @State var isFavorited: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                Circle().fill(.blue.gradient) // TODO: Maybe make function to generate random color
                    .scaledToFit()
                    .frame(width: 60)
//                Image(systemName: recipe.wrappedValue.recipeImage)
            }
            VStack(alignment: .leading) {
//                Text("\(recipe.wrappedValue.recipeName)")
//                Text("\(recipe.wrappedValue.recipeCategory)")
                }
            Spacer()
            
//            if recipe.wrappedValue.recipeIsFavorited == true {
//                Image(systemName: "star.fill")
//                    .padding(.horizontal)
//                    .foregroundStyle(.yellow)
//            } else {
//                Image(systemName: "star.fill")
//                    .padding(.horizontal)
//                    .foregroundStyle(.green)
//            }
            
            Image(systemName: "chevron.right")
            
        }
        .padding(.vertical)
//        Divider()
    }
}

#Preview {
    RecipeListItemView(recipe: .constant(MyRecipes.demoRecipes))
}
