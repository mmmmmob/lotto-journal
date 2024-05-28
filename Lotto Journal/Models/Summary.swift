//
//  Summary.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 28.05.2024.
//

import Foundation
import SwiftData

@Model
class Summary {
    var drawDates: [DrawDate]
    
    init(drawDates: [DrawDate]) {
        self.drawDates = drawDates
    }
    
    /*
    var sumOfProfitAndLoss: Int {
        return 0
    }
    var percentageOfWinning: Int {
        return 0
    }
    var allTimeInvestment: Int {
        return 0
    }
    var allTimePrizeWon: Int {
        return 0
    }
    */
}

