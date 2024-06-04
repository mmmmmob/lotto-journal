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
    var amountWon: Int
    @Relationship(deleteRule: .nullify, inverse: \DrawDate.lotteries) var drawDate: DrawDate?
    
    init(number: String, amount: Int, status: Status = .isWaiting, drawDate: DrawDate? = nil, amountWon: Int = 0) {
        self.number = number
        self.amount = amount
        self.status = status
        self.drawDate = drawDate
        self.amountWon = amountWon
    }
    
    var investmentPerLottery: Int {
        return amount * 80
    }
    
    var prizePerNumber: Int {
        return amountWon * amount
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
            "Waiting 🗿"
        case .doesWon:
            "You Won! 🎉"
        case .doesNotWon:
            "Didn't Win 😢"
        }
    }
}
