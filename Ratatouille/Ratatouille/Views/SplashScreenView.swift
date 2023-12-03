//
//  SplashScreenView.swift
//  Ratatouille
//
//  Created by Simen Hansen on 14/11/2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State var size = 0.8
    @State var opacity = 0.5
    @State var rotateDegree = 0.0
    
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
                        Image("ratatouille")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                    .rotationEffect(Angle(degrees: rotateDegree))
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 2.0)) {
                            self.rotateDegree = 45.0
                            self.size = 1.2
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
