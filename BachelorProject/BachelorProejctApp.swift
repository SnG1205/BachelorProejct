//
//  BachelorProejctApp.swift
//  BachelorProejct
//
//  Created by Sergey Holiev on 14.05.24.
//

import SwiftUI
import SwiftData

@main
struct BachelorProejctApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            User.self,
            Balance.self,
            Stock.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomePageView()
        }
        .modelContainer(sharedModelContainer)
    }
}
