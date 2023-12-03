//
//  AddNewView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 03/12/2023.
//

import SwiftUI

struct AddNewView: View {
    
    var textFieldText: Binding<String>
    var newObjectName: Binding<String>
    
    var body: some View {
        TextField(textFieldText.wrappedValue, text: newObjectName)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .presentationDetents([.height(200)])
            .textFieldStyle(.roundedBorder)
            .padding()
    }
}

#Preview {
    AddNewView(textFieldText: .constant(""), newObjectName: .constant(""))
}
