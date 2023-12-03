//
//  SettingsView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct SettingsView: View {
    
//    @State var darkModeToggle: Bool = false
    @Environment(\.managedObjectContext) var moc    
    var darkModeToggle: Binding<Bool>
    
    var savedRecipes: Binding<[Recipe]>
    var archivedRecipes: Binding<[Recipe]>
    
    var body: some View {
        VStack {
            NavigationStack {
//                HStack {
//                    Text("Innstillinger")
//                    Spacer()
//                }
//                .padding(.leading, 20)
//                .font(.title)
//                .fontWeight(.bold)
//                
                
                List {
                    Section {
                        NavigationLink {
                            ManageAreasView()
                        } label: {
                            Label("Redigere landområder", systemImage: "globe")
                            //                                .foregroundStyle(.blue)
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
                        
//                            .preferredColorScheme(darkModeToggle.wrappedValue ? .dark : .light)
                        // TODO: save darkModeToggle as Keychain or Codable to keep persitency
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
//        .onDisappear {
//            let defaults = UserDefaults.standard
//            defaults.set(darkModeToggle, forKey: "DarkOrLightMode")
//        }
    }
}

#Preview {
    SettingsView(darkModeToggle: .constant(false), savedRecipes: .constant(MyRecipes.demoRecipes), archivedRecipes: .constant(MyRecipes.demoRecipes))
}
