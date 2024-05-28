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
    var lotteries = [Lottery]()
    
    init(date: Date) {
        self.date = date
    }
}
