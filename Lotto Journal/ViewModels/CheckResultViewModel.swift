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
    
    @Published var result = ResultLotto()
    

    
            
    func CheckResultAPI(_ payload: Parameters) {
        
        let pathFirstPrize: [JSONSubscriptType] = ["response","result","data","first","number",0,"value"]
        let pathTwoDigitPrize: [JSONSubscriptType] = ["response","result","data","last2","number",0,"value"]
        
        AF.request(
            "https://www.glo.or.th/api/checking/getLotteryResult",
            method: .post,
            parameters: payload,
            encoding: JSONEncoding.prettyPrinted,
            headers: nil)
        .validate(statusCode: 200 ..< 299)
        .responseData { response in
            let json = try? JSON(data: response.data!)
            self.result.firstPrize = json![pathFirstPrize].string ?? "nil"
            self.result.twoDigitsSuffix = json![pathTwoDigitPrize].string ?? "nil"
        }
    }
}
