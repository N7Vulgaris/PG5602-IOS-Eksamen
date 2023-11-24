//
//  SearchView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct SearchView: View {
    
    init(savedRecipes: Binding<[Recipe]> ) {
        self.savedRecipes = savedRecipes
    }
    
    @State var searchInput: String = ""
    @State var searchWindowIsPresented: Bool = false
    @State var searchResult: MyRecipes = MyRecipes.init(recipes: [Recipe]())
    
    @State var apiClient = RecipesAPIClient.live
    
    var savedRecipes: Binding<[Recipe]>
    
    func getRecipesFromApi(recipeName: String) {
        Task {
            do {
                
                let searchResult = try await apiClient.getRecipesByName(recipeName)
                
                DispatchQueue.main.async {
                    self.searchResult = searchResult
                }
                
            } catch let error {
                print(error)
            }
        }
    }
    
    func saveRecipe(recipe: Binding<Recipe>) {
        savedRecipes.wrappedValue.append(recipe.wrappedValue)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Søk")
                        .fontWeight(.heavy)
                        .font(.title)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Menu {
                        Button("1") {
                            print("1")
                        }
                        Button("2") {
                            print("2")
                        }
                        Button("3") {
                            print("3")
                        }
                    } label: {
                        Image(systemName: "globe")
                            .resizable()
                            .modifier(DropdownIconStyle())
                    }
                    Menu {
                        Button("4") {
                            print("4")
                        }
                        Button("5") {
                            print("5")
                        }
                        Button("6") {
                            print("6")
                        }
                    } label: {
                        Image(systemName: "rectangle.3.group.bubble")
                            .resizable()
                            .modifier(DropdownIconStyle())
                    }
                    Menu {
                        Button("7") {
                            print("7")
                        }
                        Button("8") {
                            print("8")
                        }
                        Button("9") {
                            print("9")
                        }
                    } label: {
                        Image(systemName: "carrot.fill")
                            .resizable()
                            .modifier(DropdownIconStyle())
                    }
                }
                
                HStack {
                    TextField("Søk...", text: $searchInput)
                    Spacer()
                    
                    Button("Søk") {
                        getRecipesFromApi(recipeName: searchInput)
                    }
                }
                .padding(.horizontal)
                
                
                List {
                    ForEach($searchResult.recipes) { recipe in
                        NavigationLink {
                            RecipeDetailView(recipe: recipe)
                        } label: {
                            SearchListItemView(recipe: recipe)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(action: {
                                        saveRecipe(recipe: recipe)
                                        print("trailing")
                                        print(savedRecipes.wrappedValue)
                                    }, label: {
                                        Image(systemName: "square.grid.3x1.folder.fill.badge.plus")
                                            .tint(.blue)
                                    })
                                }
                        }
                    }
                    
                }
                
            }
        }
    }
}

#Preview {
    SearchView(savedRecipes: .constant( [Recipe]() ))
}
