//
//  CircularLoaders.swift
//  AI-generator
//
//  Created by Руслан Каприор on 19.09.2024.
//

import SwiftUI

struct CircularProgressBar: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.textGray.opacity(0.1),
                    lineWidth: 6
                )
            Text("\(Int(progress * 100))%")
                .font(.system(size: 34, design: .monospaced))
                .foregroundColor(.white)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.textSelected,
                    style: StrokeStyle(
                        lineWidth: 6,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)

        }
        .frame(maxWidth: UIScreen.main.bounds.width/2, maxHeight: UIScreen.main.bounds.width/2)
    }
}


struct CircularLoader: View {
    @State private var rotationAngle = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.textGray.opacity(0.1),
                    lineWidth: 6
                )
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(
                    Color.textSelected,
                    style: StrokeStyle(
                        lineWidth: 6,
                        lineCap: .round
                    )
                )

        }
        .frame(maxWidth: UIScreen.main.bounds.width/2, maxHeight: UIScreen.main.bounds.width/2)
        .rotationEffect(.degrees(rotationAngle))
        .onAppear {
            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                rotationAngle = 360.0
            }
        }
        .onDisappear{
            rotationAngle = 0.0
        }
    }
}

#Preview {
    ZStack{
        Color.background.ignoresSafeArea()
        CircularProgressBar(progress: 0.4)
    }
}
