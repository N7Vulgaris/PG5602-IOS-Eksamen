//
//  MyRecipes.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import Foundation

struct MyRecipes: Codable {
    
//    let id: Int
//    let id: UUID = UUID()
//    
//    let recipeName: String
//    let recipeImage: String
//    let recipeCategory: String
//    var recipeIsFavorited: Bool?
//    
//    enum CodingKeys: String, CodingKey {
//        case recipeName = "strMeal"
//        case recipeImage = "strMealThumb"
//        case recipeCategory = "strCategory"
//    }
    
    var recipes: [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case recipes = "meals"
    }
    
}

struct Recipe: Identifiable, Codable {
    let id: UUID = UUID()
    
    let recipeName: String
    let recipeImage: String
    let recipeCategory: String
    var recipeIsFavorited: Bool?
    
    enum CodingKeys: String, CodingKey {
        case recipeName = "strMeal"
        case recipeImage = "strMealThumb"
        case recipeCategory = "strCategory"
    }
}

extension MyRecipes {
    
    static var sampleJSON: String {
        """
        [{
        "strMeal" : "Burger",
        "strMealThumb" : "carrot.fill",
        "strCategory" : "Dinner",
        },
        {"strMeal" : "Fiskekaker",
        "strMealThumb" : "bile",
        "strCategory" : "Supper",
        }
        ]
        """
    }
    
}


extension MyRecipes {
    
    static var demoRecipes = MyRecipes.init(recipes: [
        Recipe.init(recipeName: "Lapskaus", recipeImage: "carrot.fill", recipeCategory: "Dinner", recipeIsFavorited: false),
        Recipe.init(recipeName: "Får i kål", recipeImage: "carrot.fill", recipeCategory: "Dinner", recipeIsFavorited: true),
        Recipe.init(recipeName: "Burger", recipeImage: "carrot.fill", recipeCategory: "Breakfast", recipeIsFavorited: false)
    ])
    
    static var demoArchivedRecipes = MyRecipes.init(recipes: [
            Recipe.init(recipeName: "Burger", recipeImage: "carrot.fill", recipeCategory: "Dinner", recipeIsFavorited: true),
            Recipe.init(recipeName: "Lapskaus", recipeImage: "carrot.fill", recipeCategory: "Dinner", recipeIsFavorited: false)
        ])
}
