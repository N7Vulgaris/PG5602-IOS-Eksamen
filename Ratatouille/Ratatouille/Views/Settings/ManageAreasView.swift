//
//  ManageAreasView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 03/12/2023.
//

import SwiftUI
import CoreData

struct ManageAreasView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedAreas: FetchedResults<Area>
    
    @State var isShowingAddNewArea: Bool = false
    @State var newAreaName: String = ""
    @State var addNewText: String = "Nytt Område"
    
    @State var isPresentingDeleteAlert: Bool = false
    
    func deleteArea(areaToDelete: Area) {
        moc.delete(areaToDelete)
        moc.saveAndPrintError()
    }
    
    func addNewArea(newArea: String) {
        let area = Area(context: moc)
        area.name = newArea
        moc.saveAndPrintError()
        isShowingAddNewArea = false
    }
    
    func deleteAllAreas() {
        for area in savedAreas {
            moc.delete(area)
        }
        moc.saveAndPrintError()
    }
    
    func no() {
        isPresentingDeleteAlert = false
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
                    action: deleteAllAreas
                    ))
                })
                
                AddNewButton(isShowingAddNew: $isShowingAddNewArea)
                    .sheet(isPresented: $isShowingAddNewArea, content: {
                        AddNewView(textFieldText: $addNewText, newObjectName: $newAreaName)
                        Button {
                            addNewArea(newArea: newAreaName)
                        } label: {
                            Text("Legg til nytt område")
                        }
                    })
            }
            
            List {
                ForEach(savedAreas) { area in
                    Text(area.name ?? "")
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(action: {
                                deleteArea(areaToDelete: area)
                            }, label: {
                                Image(systemName: "xmark.bin.fill")
                                    .tint(.red)
                            })
                        }
                }
            }
            .navigationTitle("Rediger områder")
        }
    }
}

#Preview {
    ManageAreasView()
}
