//
//  DrawDate.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 28.05.2024.
//

import Foundation
import SwiftData

@Model
class DrawDate {
    var date: Date
    @Relationship(deleteRule: .cascade, inverse: \Lottery.drawDate) var lotteries = [Lottery]()
    
    init(date: Date) {
        self.date = date
    }
    
    /*
    var sumOfInvestment: Int {
        return 0
    }
    var sumOfPrizeWon: Int {
        return 0
    }
    var profitAndLoss: Int {
        return 0
    }
    var finalAmountBought: Int {
        return 0
    }
    var finalAmountWon: Int {
        return 0
    }
    */
    
    // var summary: Summary?
}
