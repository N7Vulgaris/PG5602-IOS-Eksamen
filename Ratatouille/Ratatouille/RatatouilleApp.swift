//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by Simen Hansen on 13/11/2023.
//

import SwiftUI

@main
struct RatatouilleApp: App {
    @State var splashCreenSsActive = true
    
//    @State var savedRecipes: MyRecipes = MyRecipes(recipes: [Recipe]())
    @State var savedRecipes = [Recipe]()
    @State var archivedRecipes: MyRecipes = MyRecipes.demoArchivedRecipes
    
    var body: some Scene {
        WindowGroup {
            if splashCreenSsActive {
                SplashScreenView(isActive: $splashCreenSsActive)
            } else {
                
                Text("Ratatouille")
                
                TabView {
                    MyRecipesView(savedRecipes: $savedRecipes, archivedRecipes: $archivedRecipes)
                        .tabItem {
                            Label("Mine oppskrifter", systemImage: "fork.knife.circle")
                        }
                    
                    SearchView(savedRecipes: $savedRecipes)
                        .tabItem {
                            Label("Søk", systemImage: "magnifyingglass.circle")
                        }
                    
                    SettingsView()
                        .tabItem {
                            Label("Innstillinger", systemImage: "gearshape.fill")
                        }
                }
                
            }
        }
    }
}
