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
    
    private let qaService = QAService.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            MainTabView(selectedTab: 1)
                .environmentObject(qaService)
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([Summary.self])
        let config = ModelConfiguration("LotteryDB", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
