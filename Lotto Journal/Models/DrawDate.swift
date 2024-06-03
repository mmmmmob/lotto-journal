//
//  DrawDate.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 28.05.2024.
//

import Foundation
import SwiftData
import Alamofire

@Model
class DrawDate {
    var date: Date
    var lotteries = [Lottery]()
    
    init(date: Date) {
        self.date = date
    }
    
    var params: Parameters {
        var lotteryNum: [Dictionary<String, String>] = []
        
        for lottery in lotteries {
            lotteryNum.append(["lottery_num" : lottery.number])
        }
        
        return [
            "number" : lotteryNum,
            "period_date": self.date.periodDate
        ]
    }
    
    var totalInvestment: Int {
        var total: Int = 0
        for lottery in lotteries {
            total += lottery.investmentPerLottery
        }
        return total
    }
}
