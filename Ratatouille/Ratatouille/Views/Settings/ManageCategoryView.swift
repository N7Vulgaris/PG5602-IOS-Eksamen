//
//  ManageCategoryView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 03/12/2023.
//

import SwiftUI
import CoreData

struct ManageCategoryView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedCategories: FetchedResults<Category>
    
    @State var isShowingAddNewCategory: Bool = false
    @State var newCategoryName: String = ""
    @State var addNewText: String = "Ny Kategori"
    
    @State var isPresentingDeleteAlert: Bool = false
    
    func deleteCategory(categoryToDelete: Category) {
        moc.delete(categoryToDelete)
        moc.saveAndPrintError()
    }
    
    func addNewCategory(newCategory: String) {
        let category = Category(context: moc)
        category.name = newCategory
        moc.saveAndPrintError()
        isShowingAddNewCategory = false
    }
    
    func no() {
        isPresentingDeleteAlert = false
    }
    
    func deleteAllCategories() {
        for category in savedCategories {
            moc.delete(category)
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
                    action: deleteAllCategories
                    ))
                })
                
                AddNewButton(isShowingAddNew: $isShowingAddNewCategory)
                    .sheet(isPresented: $isShowingAddNewCategory, content: {
                        AddNewView(textFieldText: $addNewText, newObjectName: $newCategoryName)
                        Button {
                            addNewCategory(newCategory: newCategoryName)
                        } label: {
                            Text("Legg til ny kategori")
                        }
                    })
            }
            
            List {
                ForEach(savedCategories) { category in
                    Text(category.name ?? "")
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(action: {
                                deleteCategory(categoryToDelete: category)
                            }, label: {
                                Image(systemName: "xmark.bin.fill")
                                    .tint(.red)
                            })
                        }
                }
            }
            .navigationTitle("Rediger kategorier")
        }
    }
}

#Preview {
    ManageCategoryView()
}
