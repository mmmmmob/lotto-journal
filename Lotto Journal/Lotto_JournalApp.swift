//
//  Lotto_JournalApp.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI
import SwiftData

@main
struct Lotto_JournalApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MyLotto.self,
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
            MainTabView(selectedTab: 1)
        }
        .modelContainer(sharedModelContainer)
    }
}
