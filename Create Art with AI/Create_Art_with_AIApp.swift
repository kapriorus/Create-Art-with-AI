//
//  Create_Art_with_AIApp.swift
//  Create Art with AI
//
//  Created by Руслан Каприор on 30.09.2024.
//

import SwiftUI

@main
struct Create_Art_with_AIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
