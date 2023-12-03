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
    
    @State var isPresentingDeleteAlert: Bool = false
    
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
    
    func no() {
        isPresentingDeleteAlert = false
    }
    
    func deleteAllIngredients() {
        for ingredient in savedIngredients {
            moc.delete(ingredient)
        }
        
        moc.saveAndPrintError()
    }

    var body: some View {
        VStack {
            
            HStack {
                Button {
                    isPresentingDeleteAlert = true
                } label: {
                    Text("Slett alle")
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .alert(isPresented: $isPresentingDeleteAlert, content: {
                    Alert(title: Text("Er du sikker?"), primaryButton: .default(
                    Text("Nei"),
                    action: no
                    ), secondaryButton: .destructive(
                        Text("Ja"),
                    action: deleteAllIngredients
                    ))
                })
                
                AddNewButton(isShowingAddNew: $isShowingAddNewIngredient)
                    .sheet(isPresented: $isShowingAddNewIngredient, content: {
                        AddNewView(textFieldText: $addNewText, newObjectName: $newIngredientName)
                        Button {
                            addNewIngredient(newIngredient: newIngredientName)
                        } label: {
                            Text("Legg til ny ingrediens")
                        }
                    })
            }
            
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
