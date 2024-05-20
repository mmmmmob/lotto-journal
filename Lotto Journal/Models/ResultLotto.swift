//
//  ResultLotto.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import Alamofire

/* Struct for POST json request */
struct RequestDate {
    var date: String
    var month: String
    var year: String
    
    var params: Parameters {
        return [
            "date": self.date,
            "month": self.month,
            "year": self.year
        ]
    }
}
