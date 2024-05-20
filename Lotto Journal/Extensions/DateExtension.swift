//
//  DateExtension.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import Foundation

extension Date {
    
    var date: String {
        let calendar = Calendar.current
        return String(calendar.component(.day, from: self))
    }
    
    var month: String {
        let calendar = Calendar.current
        return String(calendar.component(.month, from: self))
    }
    
    var year: String {
        let calendar = Calendar.current
        return String(calendar.component(.year, from: self))
    }
    
    var nameOfMonth: String {
            let calendar = Calendar.current
            switch calendar.component(.month, from: self) {
            case 1:
                return "January"
            case 2:
                return "February"
            case 3:
                return "March"
            case 4:
                return "April"
            case 5:
                return "May"
            case 6:
                return "June"
            case 7:
                return "July"
            case 8:
                return "August"
            case 9:
                return "September"
            case 10:
                return "October"
            case 11:
                return "November"
            default:
                return "December"
            }
        }
}
