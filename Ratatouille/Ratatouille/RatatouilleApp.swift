//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by Simen Hansen on 13/11/2023.
//

import SwiftUI
import CoreData

@main
struct RatatouilleApp: App {
    
    @State var splashCreenSsActive = true
    
    @State var savedRecipes = [Recipe]()
    @State var archivedRecipes = [Recipe]()
    
    @State var darkModeToggle: Bool = false
    
    @StateObject var dataController = DataController()
    
    func retrieveDarkMode() {
        darkModeToggle = UserDefaults.standard.bool(forKey: "DarkModeToggle")
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
                    
                    SettingsView(darkModeToggle: $darkModeToggle, savedRecipes: $savedRecipes, archivedRecipes: $archivedRecipes)
                        .tabItem {
                            Label("Innstillinger", systemImage: "gearshape.fill")
                        }
                }
                .onAppear {
                    retrieveDarkMode()
                }
                .preferredColorScheme(darkModeToggle ? .dark : .light)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                
            }
        }
    }
}
