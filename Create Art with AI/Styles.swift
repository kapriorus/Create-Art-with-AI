//
//  Styles.swift
//  AI-generator
//
//  Created by Руслан Каприор on 18.09.2024.
//

import SwiftUI


struct BlueButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                !isEnabled ?
                LinearGradient(gradient: Gradient(colors: [.disabled, .disabled]), startPoint: .leading, endPoint: .trailing)
                :
                LinearGradient(gradient: Gradient(colors: [.primaryGradientStart, .primaryGradientEnd]), startPoint: .leading, endPoint: .trailing)
            )
            .foregroundColor(.primaryGradientText)
            .opacity(!isEnabled ? 0.3 : 1)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
