//
//  SplashScreenView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var size = 0.8
    @State private var opacity = 0.5
    var isActive: Binding<Bool>
    
    init(isActive: Binding<Bool>) {
        self.isActive = isActive
    }
    
    var body: some View {
        
            ZStack {
                Color.black
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Image(systemName: "hare.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.red)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive.wrappedValue = false
                        }
                    }
                }
            }
    }
}

#Preview {
    SplashScreenView(isActive: .constant(true))
}
