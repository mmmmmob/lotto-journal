//
//  ResultLotto.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//
import Foundation
import SwiftyJSON

struct ResultLotto {
    // Store prize result
    var firstPrize: String = ""
    var threeDigitsPrefix: [String] = [""]
    var threeDigitsSuffix: [String] = [""]
    var twoDigitsSuffix: String = ""
    var firstPrizeNeighbors: [String] = [""]
    var secondPrize: [String] = [""]
    var thirdPrize: [String] = [""]
    var fourthPrize: [String] = [""]
    var fifthPrize: [String] = [""]
    
    // Identifying objects
    var latestResultDate: String = ""
    var userResult: [JSON] = []
    var fetchNumberStatus: Int = 500
    var fetchLatestStatus: Int = 500
    var fetchDrawStatus: Int = 500
}
