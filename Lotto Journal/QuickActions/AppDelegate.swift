//
//  AppDelegate.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 23.05.2024.
//

import UIKit

// working with SceneDelefate to take shortcut item reference and make sure the right view is navigated to from the selected quic action
class AppDelegate: NSObject, UIApplicationDelegate {
    private let qaService = QAService.shared
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        if let shortcutItem = options.shortcutItem {
            qaService.action = QA(shortcutItem: shortcutItem)
        }
        let configuration = UISceneConfiguration(name: connectingSceneSession.configuration.name, sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}
