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
    
    var body: some View {
        VStack {
            
            AddNewButton(isShowingAddNew: $isShowingAddNewCategory)
            .sheet(isPresented: $isShowingAddNewCategory, content: {
                AddNewView(textFieldText: $addNewText, newObjectName: $newCategoryName)
                Button {
                    addNewCategory(newCategory: newCategoryName)
                } label: {
                    Text("Legg til ny kategori")
                }
            })
            
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
