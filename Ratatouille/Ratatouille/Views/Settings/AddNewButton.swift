//
//  AddNewButton.swift
//  Ratatouille
//
//  Created by Simen Hansen on 03/12/2023.
//

import SwiftUI

struct AddNewButton: View {
    
    var isShowingAddNew: Binding<Bool>
    
    var body: some View {
        Button {
//            isShowingAddNewArea = true
            isShowingAddNew.wrappedValue = true
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
    }
}

#Preview {
    AddNewButton(isShowingAddNew: .constant(true))
}
