//
//  SplashScreen.swift
//  Create Art with AI
//
//  Created by Руслан Каприор on 30.09.2024.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale = 0.7
    @Binding var isActive: Bool
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "scribble.variable")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                Text("Scribble App")
                    .font(.system(size: 20))
            }.scaleEffect(scale)
            .onAppear{
                withAnimation(.easeIn(duration: 0.7)) {
                    self.scale = 0.9
                }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

fileprivate struct SplashScreenPreview: View {
    @State var isActive: Bool = false
    
    var body: some View {
        SplashScreen(isActive: $isActive)
    }
}

#Preview {
    SplashScreenPreview()
}
