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
        VStack {
            HStack {
                Text("Søk")
                    .fontWeight(.heavy)
                    .font(.title)
                Spacer()
            }
            .padding(.horizontal)
            
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
                    SearchListItemView(recipe: recipe)
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button(action: {
                                print("leading")
                            }, label: {
                                Image(systemName: "star.fill")
                                    .tint(.yellow)
                            })
                        }
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
        .onAppear {
            print(savedRecipes)
            print("--------------------------------------------------------------------")
        }
    }
}

#Preview {
    SearchView(savedRecipes: .constant( [Recipe]() ))
}
