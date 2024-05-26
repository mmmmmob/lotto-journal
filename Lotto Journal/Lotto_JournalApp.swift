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
    
    var body: some Scene {
        WindowGroup {
            MainTabView(selectedTab: 1)
                .environmentObject(qaService)
        }
        .modelContainer(for: Lottery.self)
    }
}
