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
    
    var recipeName: String
    let recipeImage: String?
    let recipeCategory: String?
    let recipeArea: String?
    let recipeInstructions: String
    let recipeIngredient1: String?
    let recipeIngredient2: String?
    let recipeIngredient3: String?
//    let recipeIngredients: [String]
    
    var recipeIsFavorited: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case recipeName = "strMeal"
        case recipeImage = "strMealThumb"
        case recipeCategory = "strCategory"
        case recipeArea = "strArea"
        case recipeInstructions = "strInstructions"
        case recipeIngredient1 = "strIngredient1"
        case recipeIngredient2 = "strIngredient2"
        case recipeIngredient3 = "strIngredient3"
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
    
    static var demoRecipes = [
        Recipe.init(recipeName: "Lapskaus",
                    recipeImage: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg",
                    recipeCategory: "Dinner",
                    recipeArea: "Norway",
                    recipeInstructions: "Just put that shit together and eat it, dawg.",
                    recipeIngredient1: "Lap",
                    recipeIngredient2: "Skaus",
                    recipeIngredient3: "Knekkebrød",
                    recipeIsFavorited: false),
        Recipe.init(recipeName: "Får i kål",
                    recipeImage: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg",
                    recipeCategory: "Dinner",
                    recipeArea: "Norway",
                    recipeInstructions: "Grab some får. Grab some kål. Now you've got får i kål",
                    recipeIngredient1: "Får",
                    recipeIngredient2: "Kål",
                    recipeIngredient3: "Potit",
                    recipeIsFavorited: true),
        Recipe.init(recipeName: "Burger",
                    recipeImage: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg",
                    recipeCategory: "Breakfast",
                    recipeArea: "USA",
                    recipeInstructions: "1. Bread 2. Meat 3. Bacon 4. Enjoy",
                    recipeIngredient1: "Ham",
                    recipeIngredient2: "Burger",
                    recipeIngredient3: "Bacon",
                    recipeIsFavorited: true)
    ]
    
    static var demoRecipe = Recipe(
        recipeName: "Tacos",
        recipeImage: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg",
        recipeCategory: "Dinner",
        recipeArea: "Mexico",
        recipeInstructions: "Spinkle some good shit in a Taco Shell and you're good to go!",
        recipeIngredient1: "Meat",
        recipeIngredient2: "Taco shell",
        recipeIngredient3: "The green stuff",
        recipeIsFavorited: true)
    
    
    static var demoArchivedRecipes = MyRecipes.init(recipes: [
            Recipe.init(recipeName: "Burger", 
                        recipeImage: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg",
                        recipeCategory: "Dinner",
                        recipeArea: "USA",
                        recipeInstructions: "1. Bread 2. Meat 3. Bacon 4. Enjoy",
                        recipeIngredient1: "Ham",
                        recipeIngredient2: "Burger",
                        recipeIngredient3: "Bacon",
                        recipeIsFavorited: true),
            Recipe.init(recipeName: "Lapskaus",
                        recipeImage: "https://www.themealdb.com/images/media/meals/o7p9581608589317.jpg",
                        recipeCategory: "Dinner",
                        recipeArea: "Norway",
                        recipeInstructions: "Just put that shit together and eat it, dawg.",
                        recipeIngredient1: "Lap",
                        recipeIngredient2: "Skaus",
                        recipeIngredient3: "Knekkebrød",
                        recipeIsFavorited: false)
        ])
}
