//
//  SearchView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI
import CoreData

struct SearchView: View {
    
    init(savedRecipes: Binding<[Recipe]> ) {
        self.savedRecipes = savedRecipes
    }
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedAreas: FetchedResults<Area>
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedCategories: FetchedResults<Category>
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedIngredients: FetchedResults<Ingredient>
    
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
    
    func getAreasFromApi(recipeArea: String) {
        Task {
            do {
                
                let searchResult = try await apiClient.getRecipesByArea(recipeArea)
                
                print(searchResult.meal)
                
                
//                DispatchQueue.main.async {
//                    self.searchResult = searchResult
//                }
                
            } catch let error {
                print(error)
            }
        }
    }

    
    func saveRecipe(recipe: Binding<Recipe>) {
        
        let meal = Meal(context: moc)
        let area = Area(context: moc)
        let category = Category(context: moc)
        let ingredient1 = Ingredient(context: moc)
        
        area.name = recipe.wrappedValue.recipeArea
        category.name = recipe.wrappedValue.recipeCategory
        ingredient1.name = recipe.wrappedValue.recipeIngredient1
//        ingredient2.name = recipe.wrappedValue.recipeIngredient2
//        ingredient3.name = recipe.wrappedValue.recipeIngredient3
        // TODO: Change it so that ALL the ingredients are converted and added
        
        meal.name = recipe.wrappedValue.recipeName
        meal.imageUrl = recipe.wrappedValue.recipeImage
        meal.isFavorited = recipe.wrappedValue.recipeIsFavorited
//        meal.isArchived = recipe.wrappedValue.recipeIsArchived
        meal.area = area
        meal.category = category
//        meal.ingredient = [ingredient1, ingredient2, ingredient3]
        meal.ingredient = ingredient1
        
        moc.saveAndPrintError()
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
                        ForEach(savedAreas) { area in
                            Button {
                                getAreasFromApi(recipeArea: area.name!)
                            } label: {
                                Text("\(area.name ?? "")")
                            }
                        }
                    } label: {
                        Image(systemName: "globe")
                            .resizable()
                            .modifier(DropdownIconStyle())
                    }
                    Menu {
//                        ForEach(savedCategories) { category in
//                            Button {
//                                getCategoryFromApi(recipeCategory: area.name!)
//                            } label: {
//                                Text("\(area.name ?? "")")
//                            }
//                        }
                    } label: {
                        Image(systemName: "rectangle.3.group.bubble")
                            .resizable()
                            .modifier(DropdownIconStyle())
                    }
                    Menu {
//                        ForEach(savedIngredients) { ingredient in
//                            Button {
//                                getIngredientsFromApi(recipeIngredient: area.name!)
//                            } label: {
//                                Text("\(area.name ?? "")")
//                            }
//                        }
                    } label: {
                        Image(systemName: "carrot.fill")
                            .resizable()
                            .modifier(DropdownIconStyle())
                    }
                }
                
                HStack {
                    TextField("Søk...", text: $searchInput)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
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
                            RecipeListItemView(recipe: recipe)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(action: {
                                        saveRecipe(recipe: recipe)
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

extension NSManagedObjectContext {
    func saveAndPrintError() {
        do {
            try self.save()
        } catch let error {
            print(error)
        }
    }
}
