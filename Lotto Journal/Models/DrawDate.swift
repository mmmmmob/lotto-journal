//
//  DrawDate.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 28.05.2024.
//

import Foundation
import SwiftData
import Alamofire
import SwiftyJSON

@Model
class DrawDate {
    var date: Date
    var result: [JSON] = []
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
    
    // extract JSON value into Dictionary
    var lotteryPrizeResult: [Dictionary<String, String>] {
        var prizeResult = [Dictionary<String, String>]()
        let pathPrize: [JSONSubscriptType] = ["status_data", 0, "reward"]
        let pathNumber: [JSONSubscriptType] = ["number"]
        for prize in self.result {
            var prizePair = Dictionary<String,String>()
            prizePair[prize[pathNumber].string!] = prize[pathPrize].string ?? "-"
            prizeResult.append(prizePair)
        }
        return prizeResult
    }
    
    var totalInvestment: Int {
        var total: Int = 0
        for lottery in lotteries {
            total += lottery.investmentPerLottery
        }
        return total
    }
    
    var totalWon: Int {
        var total: Int = 0
        for lottery in lotteries {
            total += lottery.prizePerNumber
        }
        return total
    }
}
