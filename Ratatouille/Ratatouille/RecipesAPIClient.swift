//
//  RecipesAPIClient.swift
//  Ratatouille
//
//  Created by Simen Hansen on 21/11/2023.
//

import Foundation


struct RecipesAPIClient {
    
    var getRecipesByName: ( (String) async throws -> MyRecipes)
    
}

extension RecipesAPIClient {
    
    static let live = RecipesAPIClient(getRecipesByName: { recipeName in
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(recipeName)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let recipes = try JSONDecoder().decode(MyRecipes.self, from: data)
        
        return recipes
        
    })
    
}
