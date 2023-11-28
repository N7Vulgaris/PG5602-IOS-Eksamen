//
//  SettingsView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct SettingsView: View {
    
//    @State var darkModeToggle: Bool = false
    var darkModeToggle: Binding<Bool>
    
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
                            Text("Landområder")
                        } label: {
                            Label("Redigere landområder", systemImage: "globe")
                            //                                .foregroundStyle(.blue)
                        }
                        NavigationLink {
                            Text("Kategorier")
                        } label: {
                            Label("Redigere kategorier", systemImage: "rectangle.3.group.bubble")
                        }
                        NavigationLink {
                            Text("Ingredienser")
                        } label: {
                            Label("Redigere ingredienser", systemImage: "carrot.fill")
                        }
                    }
                    Section {
                        Toggle("Akriver mørk modus", systemImage: "moon.circle", isOn: darkModeToggle)
                            .onChange(of: darkModeToggle.wrappedValue) {
                                // TODO: Improve this. It doesn't alwasy save correctyl
                                UserDefaults.standard.set(darkModeToggle.wrappedValue, forKey: "DarkModeToggle")
                            }
                        
//                            .preferredColorScheme(darkModeToggle.wrappedValue ? .dark : .light)
                        // TODO: save darkModeToggle as Keychain or Codable to keep persitency
                    }
                    Section {
                        Label("Administrere arkiv", systemImage: "xmark.bin.fill")
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
    SettingsView(darkModeToggle: .constant(false))
}
