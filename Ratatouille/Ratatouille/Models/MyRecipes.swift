//
//  MyRecipes.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import Foundation

struct MyRecipes: Identifiable {
    var id: Int
    // TODO: change id to ObjectIdentifier or UUID later
    let recipeName: String
    let recipeImage: String
    let recipeCategpry: String
    
}


extension MyRecipes {
    
    static let demoRecipes = [
        MyRecipes.init(id: 1, recipeName: "Lapskaus", recipeImage: "carrot.fill", recipeCategpry: "Dinner"),
        MyRecipes.init(id: 2, recipeName: "Får i kål", recipeImage: "carrot.fill", recipeCategpry: "Dinner"),
        MyRecipes.init(id: 3, recipeName: "Burger", recipeImage: "carrot.fill", recipeCategpry: "Breakfast"),
    ]
    
}
