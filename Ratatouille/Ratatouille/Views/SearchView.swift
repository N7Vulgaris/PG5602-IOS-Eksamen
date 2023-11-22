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
    
    func onAppear(recipeName: String) {
        Task {
            do {
//                let searchResult = try await apiClient.getRecipesByName(searchInput)
                
                let url=URL(string:"https://www.themealdb.com/api/json/v1/1/search.php?s=\(recipeName)")!
                
                let (data, response) = try await URLSession.shared.data(from: url)
                let recipes = try JSONDecoder().decode(MyRecipes.self, from: data)
                
                DispatchQueue.main.async {
                    self.searchResult = recipes
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
                Spacer()
            }
            .padding(.horizontal)
            
            TextField("Søk...", text: $searchInput)
            Spacer()
            
            Button("Søk") {
                onAppear(recipeName: searchInput)
            }
            
            List {
//                ForEach(searchResult) { recipe in
//                    Text("\(recipe.recipeName)")
//                }
                
                ForEach(searchResult.recipes) { recipe in
                    Text(recipe.recipeName)
                }
            }
        }
    }
}

#Preview {
    SearchView(searchResult: MyRecipes.demoRecipes)
}
