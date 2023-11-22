//
//  MyRecipes.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import Foundation

struct MyRecipes: Codable {
    
    var recipes: [Recipe]
    
    enum CodingKeys: String, CodingKey {
        case recipes = "meals"
    }
    
}

struct Recipe: Identifiable, Codable {
    let id: UUID = UUID()
    
    let recipeName: String
    let recipeImage: URL?
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
        Recipe.init(recipeName: "Lapskaus", 
                    recipeImage: URL.init(string: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg"),
                    recipeCategory: "Dinner",
                    recipeIsFavorited: false),
        Recipe.init(recipeName: "Får i kål", 
                    recipeImage: URL.init(string: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg"),
                    recipeCategory: "Dinner",
                    recipeIsFavorited: true),
        Recipe.init(recipeName: "Burger", 
                    recipeImage: URL.init(string: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg"),
                    recipeCategory: "Breakfast",
                    recipeIsFavorited: false)
    ])
    
    static var demoArchivedRecipes = MyRecipes.init(recipes: [
            Recipe.init(recipeName: "Burger", 
                        recipeImage: URL.init(string: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg"),
                        recipeCategory: "Dinner",
                        recipeIsFavorited: true),
            Recipe.init(recipeName: "Lapskaus", 
                        recipeImage: URL.init(string: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg"),
                        recipeCategory: "Dinner",
                        recipeIsFavorited: false)
        ])
}
