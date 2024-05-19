//
//  Item.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import Foundation
import SwiftData

@Model
final class Lottery {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
