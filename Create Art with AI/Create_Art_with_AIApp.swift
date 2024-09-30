//
//  Create_Art_with_AIApp.swift
//  Create Art with AI
//
//  Created by Руслан Каприор on 30.09.2024.
//

import SwiftUI
import ApphudSDK

enum Screen {
    case onboarding
    case mainboard
}

@main
struct Create_Art_with_AIApp: App {
    let persistenceController = PersistenceController.shared
        @StateObject var viewModel = FavoritesViewModel()
        
        @State private var screen: Screen = .onboarding
        
        @AppStorage("isOnboardingComplete") var isOnboardingComplete: Bool = false

        var body: some Scene {
            
            WindowGroup {
                switch screen {
                case .onboarding:
                    if UserDefaults.standard.bool(forKey: "isOnboardingComplete") {
                        MainBoardView()
                    } else {
                        OnboardingView {
                            UserDefaults.standard.set(true, forKey: "isOnboardingComplete")
                            screen = .mainboard
                        }
                    }
                case .mainboard:
                    MainBoardView().environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
            
        }
}
