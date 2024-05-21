//
//  CheckResultViewModel.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 21.05.2024.
//

import SwiftUI
import Alamofire
import SwiftyJSON

class CheckResultViewModel: ObservableObject {
            
    func APICall(_ payload: Parameters) {
        AF.request(
            "https://www.glo.or.th/api/checking/getLotteryResult",
            method: .post,
            parameters: payload,
            encoding: JSONEncoding.prettyPrinted,
            headers: nil)
        .validate(statusCode: 200 ..< 299)
        .responseData { response in
            let json = try? JSON(data: response.data!)
            let path: [JSONSubscriptType] = ["response","result","data","first","number",0,"value"]
            print(json![path].string ?? "nil")
        }
        
    }
}
