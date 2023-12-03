//
//  RecipeDetailView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 23/11/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    
    init(recipe: Binding<Recipe>) {
        self.recipe = recipe
    }
    
    let recipe: Binding<Recipe>
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                AsyncImage(url: URL.init(string: recipe.wrappedValue.recipeImage!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Color.gray
                }
                .mask(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Navn: \(recipe.wrappedValue.recipeName)")
                    Text("Kategori: \(recipe.wrappedValue.recipeCategory!)")
                    Text("Landområde: \(recipe.wrappedValue.recipeArea!)")
                    Text("Ingredienser:")
                    Text("\(recipe.wrappedValue.recipeIngredient1!)")
                }
                .padding(.leading, 40)
                .padding(.top, 10)
                .font(.title2)
                .fontWeight(.bold)
                HStack {
                    Spacer()
                    
                    ZStack {
                        NavigationLink {
                            ScrollView {
                                Text("\(recipe.wrappedValue.recipeInstructions ?? "")")
                                    .padding(.horizontal, 50)
                                    .font(.title3)
                                    .fontWeight(.medium)
                            }
                        } label: {
                            Text("Instruksjoner")
                        }
                        .padding(.trailing, 40)
                        
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    RecipeDetailView(recipe: .constant(MyRecipes.demoRecipe))
}
