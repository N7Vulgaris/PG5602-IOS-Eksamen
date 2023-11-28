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
//    @State var savedRecipes = [Recipe]()
    @State var savedRecipes = MyRecipes.demoRecipes
    @State var archivedRecipes = [Recipe]()
    
    @State var darkModeToggle: Bool = false
    
    func retrieveDarkMode() {
        
        darkModeToggle = UserDefaults.standard.bool(forKey: "DarkModeToggle")
        
//        let defaults = UserDefaults.standard
//        
//        if case let isDarkModeOn as Bool = defaults.value(forKey: "DarkModeToggle") {
//            darkModeToggle = isDarkModeOn
//        } else {
//            return
//        }
    }
    
    var body: some Scene {
        WindowGroup {
            
            if splashCreenSsActive {
                SplashScreenView(isActive: $splashCreenSsActive)
            } else {
                
                TabView {
                    MyRecipesView(savedRecipes: $savedRecipes, archivedRecipes: $archivedRecipes)
                        .tabItem {
                            Label("Mine oppskrifter", systemImage: "fork.knife.circle")
                        }
                    
                    SearchView(savedRecipes: $savedRecipes)
                        .tabItem {
                            Label("Søk", systemImage: "magnifyingglass.circle")
                        }
                    
                    SettingsView(darkModeToggle: $darkModeToggle)
                        .tabItem {
                            Label("Innstillinger", systemImage: "gearshape.fill")
                        }
                }
                .onAppear {
                    retrieveDarkMode()
                }
                .preferredColorScheme(darkModeToggle ? .dark : .light)
                
            }
        }
    }
}
