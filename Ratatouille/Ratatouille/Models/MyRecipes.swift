//
//  MyRecipes.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import Foundation

struct MyRecipes: Identifiable {
    let id: Int
    // TODO: change id to ObjectIdentifier or UUID later
    let recipeName: String
    let recipeImage: String
    let recipeCategpry: String
    var recipeIsFavorited: Bool
    
}


extension MyRecipes {
    
    static var demoRecipes = [
        MyRecipes.init(id: 1, recipeName: "Lapskaus", recipeImage: "carrot.fill", recipeCategpry: "Dinner", recipeIsFavorited: false),
        MyRecipes.init(id: 2, recipeName: "Får i kål", recipeImage: "carrot.fill", recipeCategpry: "Dinner", recipeIsFavorited: true),
        MyRecipes.init(id: 3, recipeName: "Burger", recipeImage: "carrot.fill", recipeCategpry: "Breakfast", recipeIsFavorited: false),
    ]
    
    static var demoArchivedRecipes = [
        MyRecipes.init(id: 99, recipeName: "Kylling", recipeImage: "carrot.fill", recipeCategpry: "dinner", recipeIsFavorited: false)
    ]
    
}
