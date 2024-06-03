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
    
    var periodDate: String {
        return "\(self.year)-\(self.monthDouble)-\(self.dateDouble)"
    }
    
    var fullStringDate: String {
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
        if self.monthDouble == "01" { // for Teacher's Day
            switch self.dateDouble {
            case "17":
                return self.addingTimeInterval(1_296_000) // +15 days = 1st of Feb.
            default:
                return self
            }
        } else if self.monthDouble == "04" { // for Labor Day
            switch self.dateDouble {
            case "01":
                return self.addingTimeInterval(1_296_000) // +15 days = 16th of Apr.
            case "16":
                return self.addingTimeInterval(1_382_400) // +16 days = 2nd of May
            default:
                return self
            }
        } else if self.monthDouble == "05" { // for Labor's Day
            switch self.dateDouble {
            case "02":
                return self.addingTimeInterval(1_209_600) // + 14 days = 16th of May
            case "16":
                return self.addingTimeInterval(1_382_400) // + 16 days = 1st of Jun.
            default:
                return self
            }
        } else if self.monthDouble == "12" { // for New Year's Day
            switch self.dateDouble {
            case "01":
                return self.addingTimeInterval(1_296_000) // +15 days = 16th of Dec.
            case "16":
                return self.addingTimeInterval(1_209_600) // +14 days = 30th of Dec.
            case "30":
                return self.addingTimeInterval(1_555_200) // +17 days = 17th of Jan.
            default:
                return self
            }
        } else {
            switch self.dateDouble { // for normal Draw Date
            case "01":
                return self.addingTimeInterval(1_296_000) // +15 days = 16th of next month
            case "16":
                return self.addingTimeInterval(1_382_400) // +16 days = 1st of next month
            default:
                return self
            }
        }
    }
}
