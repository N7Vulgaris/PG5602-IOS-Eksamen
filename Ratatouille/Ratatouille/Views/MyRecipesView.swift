//
//  MyRecipesView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct MyRecipesView: View {
    
    @State var myRecipes: [MyRecipes]
    
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
            Form {
                ScrollView() {
                    ForEach(myRecipes) { recipe in
                        RecipeListItemView(recipe: recipe)
                    }
                }
                .defaultScrollAnchor(.bottom)
            }
        }
    }
    
    
}

#Preview {
    MyRecipesView(myRecipes: MyRecipes.demoRecipes)
}