//
//  RecipesAPIClient.swift
//  Ratatouille
//
//  Created by Simen Hansen on 21/11/2023.
//

import Foundation


struct RecipesAPIClient {
    
    var getRecipesByName: ( (String) async throws -> MyRecipes)
    
    var getRecipesByCategory: ((String) async throws -> MyRecipes)
    
    var getRecipesByArea: ((String) async throws -> MyRecipes)
    
    var getRecipesByIngredient: ((String) async throws -> MyRecipes)
    
    var getRecipeById: ((Int) async throws -> MyRecipes)
    
}

extension RecipesAPIClient {
    
    static let live = RecipesAPIClient(getRecipesByName: { recipeName in
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(recipeName)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let recipes = try JSONDecoder().decode(MyRecipes.self, from: data)
        
        return recipes
        
    }, getRecipesByCategory: { recipeCategory in
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(recipeCategory)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let recipes = try JSONDecoder().decode(MyRecipes.self, from: data)
        
        return recipes
    }, getRecipesByArea: { recipeArea in
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(recipeArea)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let recipes = try JSONDecoder().decode(MyRecipes.self, from: data)
        
        return recipes
        
    }, getRecipesByIngredient: { recipeIngredient in
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(recipeIngredient)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let recipes = try JSONDecoder().decode(MyRecipes.self, from: data)
        
        return recipes
        
    }, getRecipeById: { recipeId in
        
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(recipeId)")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let recipe = try JSONDecoder().decode(MyRecipes.self, from: data)
        
        return recipe
        
    })
    
}
