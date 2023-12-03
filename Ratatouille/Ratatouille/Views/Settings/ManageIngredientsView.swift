//
//  ManageIngredientsView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 03/12/2023.
//

import SwiftUI

struct ManageIngredientsView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedIngredients: FetchedResults<Ingredient>
    
    @State var isShowingAddNewIngredient: Bool = false
    @State var newIngredientName: String = ""
    @State var addNewText: String = "Ny Ingrediens"
    
    func deleteIngredient(ingredientToDelete: Ingredient) {
        moc.delete(ingredientToDelete)
        moc.saveAndPrintError()
    }
    
    func addNewIngredient(newIngredient: String) {
        let ingredient = Ingredient(context: moc)
        ingredient.name = newIngredient
        moc.saveAndPrintError()
        isShowingAddNewIngredient = false
    }

    var body: some View {
        VStack {
            AddNewButton(isShowingAddNew: $isShowingAddNewIngredient)
            .sheet(isPresented: $isShowingAddNewIngredient, content: {
                AddNewView(textFieldText: $addNewText, newObjectName: $newIngredientName)
                Button {
                    addNewIngredient(newIngredient: newIngredientName)
                } label: {
                    Text("Legg til ny ingrediens")
                }
            })
            
            List {
                ForEach(savedIngredients) { ingredient in
                    Text(ingredient.name ?? "")
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(action: {
                                deleteIngredient(ingredientToDelete: ingredient)
                            }, label: {
                                Image(systemName: "xmark.bin.fill")
                                    .tint(.red)
                            })
                        }
                }
            }
            .navigationTitle("Rediger ingredienser")
        }
    }
}

#Preview {
    ManageIngredientsView()
}
