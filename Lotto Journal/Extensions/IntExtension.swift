//
//  IntExtension.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 04.06.2024.
//

import Foundation

extension Int {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        return numberFormatter
    }()

    var delimiter: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
