//
//  QuickActionType.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 23.05.2024.
//

import UIKit

// setup enum rawValue according to 'Shortcut Item Type' on info.plist
enum QuickAction: String {
    case myLottery = "myLottery"
    case summary = "summary"
    case result = "result"
}

enum QA: Equatable {
    case myLottery
    case summary
    case result

    init?(shortcutItem: UIApplicationShortcutItem) {
        // init QA.self based on rawValue of QuickAction enum taken in as argument
        guard let action = QuickAction(rawValue: shortcutItem.type) else {
            return nil
        }
        
        switch action {
        case .myLottery:
            self = .myLottery
        case .summary:
            self = .summary
        case .result:
            self = .result
        }
    }
}

class QAService: ObservableObject {
    static let shared = QAService()
    @Published var action: QA?
}
