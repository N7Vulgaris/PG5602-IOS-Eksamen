//
//  RecipeInstructionsView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 23/11/2023.
//

import SwiftUI

struct RecipeInstructionsView: View {
    
    var recipeInstructions: String
    
    var body: some View {
        VStack {
            Text("\(recipeInstructions)")
        }
    }
}

#Preview {
    RecipeInstructionsView(recipeInstructions: "Do it")
}
