//
//  Lottery.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 25.05.2024.
//

import Foundation
import SwiftData

@Model
class Lottery {
    var number: String
    var amount: Int
    var status: Status
    
    init(number: String, amount: Int, status: Status = .isWaiting) {
        self.number = number
        self.amount = amount
        self.status = status
    }
    
    var investment: Int {
        return amount * 80
    }
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case isWaiting, doesWon, doesNotWon
    var id: Self {
        self
    }
    var description: String {
        switch self {
        case .isWaiting:
            "Waiting for Result 🗿"
        case .doesWon:
            "You Won! 🎉"
        case .doesNotWon:
            "Didn't Win... 😢"
        }
        
    }
}
