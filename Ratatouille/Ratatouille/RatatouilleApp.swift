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
    
    
    var body: some Scene {
        WindowGroup {
            if splashCreenSsActive {
                SplashScreenView(isActive: $splashCreenSsActive)
            } else {
                
                Text("Ratatouille")
                
                TabView {
                    MyRecipesView(myRecipes: MyRecipes.demoRecipes)
                        .tabItem {
                            Label("Mine oppskrifter", systemImage: "fork.knife.circle")
                        }
                    
                    SearchView()
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
