//
//  SceneDelegate.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 23.05.2024.
//

import UIKit

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    private let qaService = QAService.shared
    
    // being call when app is not already loaded -> launches the app with the grabbed reference of the shortcut item
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let shortcutItem = connectionOptions.shortcutItem {
            qaService.action = QA(shortcutItem: shortcutItem)
        }
    }
    
    // being call when app is already loaded and relaunches with referenced shortcut item
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        qaService.action = QA(shortcutItem: shortcutItem)
        completionHandler(true)
    }
    
}
