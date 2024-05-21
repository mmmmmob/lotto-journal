//
//  StringExtension.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 21.05.2024.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let stringFormat = DateFormatter()
        stringFormat.dateFormat = "yyyy-MM-dd"
        let result = stringFormat.date(from: self)
        
        return result
    }
}
