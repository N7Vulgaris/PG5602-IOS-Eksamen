//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by Simen Hansen on 13/11/2023.
//

import SwiftUI

@main
struct RatatouilleApp: App {
    @State var splashCreenSsActive = true
    
    
    var body: some Scene {
        WindowGroup {
            if splashCreenSsActive {
                SplashScreenView(isActive: $splashCreenSsActive)
            } else {
                TabView {
                    
                }
            }
        }
    }
}
