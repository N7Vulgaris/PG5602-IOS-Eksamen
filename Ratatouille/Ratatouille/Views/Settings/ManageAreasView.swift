//
//  ManageAreasView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 03/12/2023.
//

import SwiftUI

struct ManageAreasView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [.init(key: "name", ascending: true)]) var savedAreas: FetchedResults<Area>
    
    @State var isShowingAddNewArea: Bool = false
    @State var newAreaName: String = ""
    
    func deleteArea(areaToDelete: Area) {
        moc.delete(areaToDelete)
        moc.saveAndPrintError()
    }
    
    func addNewArea() {
        
    }
    
    var body: some View {
        VStack {
            
            Button {
                isShowingAddNewArea = true
            } label: {
                HStack {
                    Spacer()
                    ZStack {
                        Color.blue
                        Image(systemName: "plus")
                            .foregroundStyle(Color.white)
                    }
                    .mask(Circle())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 70)
                }
                .padding(.trailing)
            }
            .sheet(isPresented: $isShowingAddNewArea, content: {
                TextField("Nytt Område", text: $newAreaName)
            })
            
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
