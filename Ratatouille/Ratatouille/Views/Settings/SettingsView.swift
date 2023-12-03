//
//  SettingsView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI
import CoreData

struct SettingsView: View {
    
    @Environment(\.managedObjectContext) var moc    
    var darkModeToggle: Binding<Bool>
    
    var savedRecipes: Binding<[Recipe]>
    var archivedRecipes: Binding<[Recipe]>
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    Section {
                        NavigationLink {
                            ManageAreasView()
                        } label: {
                            Label("Redigere landområder", systemImage: "globe")
                        }
                        NavigationLink {
                            ManageCategoryView()
                        } label: {
                            Label("Redigere kategorier", systemImage: "rectangle.3.group.bubble")
                        }
                        NavigationLink {
                            ManageIngredientsView()
                        } label: {
                            Label("Redigere ingredienser", systemImage: "carrot.fill")
                        }
                    }
                    Section {
                        Toggle("Akriver mørk modus", systemImage: "moon.circle", isOn: darkModeToggle)
                            .onChange(of: darkModeToggle.wrappedValue) {
                                // TODO: Improve this. It doesn't alwasy save correctly
                                UserDefaults.standard.set(darkModeToggle.wrappedValue, forKey: "DarkModeToggle")
                            }
                    }
                    Section {
                        
                        NavigationLink {
                            ManageArchiveView(savedRecipes: savedRecipes, archivedRecipes: archivedRecipes)
                        } label: {
                            Label("Administrere arkiv", systemImage: "xmark.bin.fill")
                        }
                    }
                    
                }
                .navigationTitle("Innstillinger")
            }
        }
    }
}

#Preview {
    SettingsView(darkModeToggle: .constant(false), savedRecipes: .constant(MyRecipes.demoRecipes), archivedRecipes: .constant(MyRecipes.demoRecipes))
}
