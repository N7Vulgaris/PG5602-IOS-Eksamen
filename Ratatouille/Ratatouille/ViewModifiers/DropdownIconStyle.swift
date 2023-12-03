//
//  DropdownIconStyle.swift
//  Ratatouille
//
//  Created by Simen Hansen on 23/11/2023.
//

import Foundation
import SwiftUI

struct DropdownIconStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 30)
    }
}
