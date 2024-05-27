//
//  Lottery.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 25.05.2024.
//

import Foundation
import SwiftUI
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
    
    var tagSymbol: Image {
        switch status {
        case .isWaiting:
            Image(systemName: "questionmark.circle.fill")
        case .doesWon:
            Image(systemName: "checkmark.circle.fill")
        case .doesNotWon:
            Image(systemName: "xmark.circle.fill")
        }
    }
    
    var tagColor: Color {
        switch status {
        case .isWaiting:
            return .gray
        case .doesWon:
            return .green
        case .doesNotWon:
            return .red
        }
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
            "Waiting for Result"
        case .doesWon:
            "You Won!"
        case .doesNotWon:
            "Didn't Win..."
        }
        
    }
}
