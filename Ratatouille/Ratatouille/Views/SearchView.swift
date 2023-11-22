//
//  SearchView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchInput: String = ""
    @State var searchWindowIsPresented: Bool = false
    
    @State var searchResult: MyRecipes = MyRecipes.init(recipes: [])
    
    @State var apiClient = RecipesAPIClient.live
    
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
    
    var body: some View {
        VStack() {
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
                ForEach(searchResult.recipes) { recipe in
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
                                print("trailing")
                            }, label: {
                                Image(systemName: "xmark.bin.fill")
                                    .tint(.blue)
                            })
                        }
                }
                
            }
        }
    }
}

#Preview {
    SearchView(searchResult: MyRecipes.demoRecipes)
}
