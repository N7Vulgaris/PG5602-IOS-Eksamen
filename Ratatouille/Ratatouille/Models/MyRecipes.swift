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
    
}


extension MyRecipes {
    
    static let demoRecipes = [
        MyRecipes.init(id: 1, recipeName: "Lapskaus"),
        MyRecipes.init(id: 2, recipeName: "Får i kål"),
        MyRecipes.init(id: 3, recipeName: "Burger"),
    ]
    
}
