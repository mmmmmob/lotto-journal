//
//  DateExtension.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import Foundation
import Alamofire

extension Date {
    
    var dateSingle: String {
        let calendar = Calendar.current
        return String(calendar.component(.day, from: self))
    }
    
    var dateDouble: String {
        let calendar = Calendar.current
        return String(format: "%02d", calendar.component(.day, from: self))
    }
    
    var monthSingle: String {
        let calendar = Calendar.current
        return String(calendar.component(.month, from: self))
    }
    
    var monthDouble: String {
        let calendar = Calendar.current
        return String(format: "%02d", calendar.component(.month, from: self))
    }
    
    var year: String {
        let calendar = Calendar.current
        return String(calendar.component(.year, from: self))
    }
    
    var nameOfMonth: LocalizedStringResource {
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
    
    var periodDate: String {
        return "\(self.year)-\(self.monthDouble)-\(self.dateDouble)"
    }
    
    var fullStringDate: LocalizedStringResource {
        return "\(self.nameOfMonth) \(self.dateSingle), \(self.year)"
    }
    
    var params: Parameters {
        return [
            "date": self.dateSingle,
            "month": self.monthSingle,
            "year": self.year
        ]
    }
    
    var upcomingDrawDate: Date {
        let calendar = Calendar.current
        let yearVal = calendar.component(.year, from: self)
        let monthVal = calendar.component(.month, from: self)
        let dayVal = calendar.component(.day, from: self)
        
        func makeDate(year: Int, month: Int, day: Int) -> Date {
            calendar.date(from: DateComponents(year: year, month: month, day: day)) ?? self
        }
        
        switch (monthVal, dayVal) {
        case (1, 2):
            return makeDate(year: yearVal, month: 1, day: 17)
        case (1, 17):
            return makeDate(year: yearVal, month: 2, day: 1)
        case (4, 1):
            return makeDate(year: yearVal, month: 4, day: 16)
        case (4, 16):
            return makeDate(year: yearVal, month: 5, day: 2)
        case (5, 2):
            return makeDate(year: yearVal, month: 5, day: 16)
        case (12, 1):
            return makeDate(year: yearVal, month: 12, day: 16)
        case (12, 16):
            return makeDate(year: yearVal + 1, month: 1, day: 2)
        default:
            if dayVal <= 1 {
                return makeDate(year: yearVal, month: monthVal, day: 16)
            } else if dayVal <= 16 {
                let nextMonth = monthVal == 12 ? 1 : monthVal + 1
                let nextYear = monthVal == 12 ? yearVal + 1 : yearVal
                let nextDay = (nextMonth == 1 || nextMonth == 5) ? 2 : 1
                return makeDate(year: nextYear, month: nextMonth, day: nextDay)
            } else {
                let nextMonth = monthVal == 12 ? 1 : monthVal + 1
                let nextYear = monthVal == 12 ? yearVal + 1 : yearVal
                let nextDay = (nextMonth == 1 || nextMonth == 5) ? 2 : 1
                return makeDate(year: nextYear, month: nextMonth, day: nextDay)
            }
        }
    }
    
    var previousDrawDate: Date {
        let calendar = Calendar.current
        let yearVal = calendar.component(.year, from: self)
        let monthVal = calendar.component(.month, from: self)
        let dayVal = calendar.component(.day, from: self)
        
        func makeDate(year: Int, month: Int, day: Int) -> Date {
            calendar.date(from: DateComponents(year: year, month: month, day: day)) ?? self
        }
        
        switch (monthVal, dayVal) {
        case (1, 2):
            return makeDate(year: yearVal - 1, month: 12, day: 16)
        case (1, 17):
            return makeDate(year: yearVal, month: 1, day: 2)
        case (2, 1):
            return makeDate(year: yearVal, month: 1, day: 17)
        case (5, 2):
            return makeDate(year: yearVal, month: 4, day: 16)
        case (5, 16):
            return makeDate(year: yearVal, month: 5, day: 2)
        default:
            if dayVal >= 16 {
                let prevDay = (monthVal == 1 || monthVal == 5) ? 2 : 1
                return makeDate(year: yearVal, month: monthVal, day: prevDay)
            } else {
                let prevMonth = monthVal == 1 ? 12 : monthVal - 1
                let prevYear = monthVal == 1 ? yearVal - 1 : yearVal
                let prevDay = 16
                return makeDate(year: prevYear, month: prevMonth, day: prevDay)
            }
        }
    }
}
