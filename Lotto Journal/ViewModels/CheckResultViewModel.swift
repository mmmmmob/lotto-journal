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
    
    func NumberSearchAPI(searchNum: String, date: String) {
        AF.request(
            "https://www.glo.or.th/api/checking/getcheckLotteryResult",
            method: .post,
            parameters: [
                "number": [
                    ["lottery_num" : searchNum]
                ],
                "period_date": date
            ],
            encoding: JSONEncoding.prettyPrinted,
            headers: nil)
        .validate(statusCode: 200 ..< 299)
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    let pathResult: [JSONSubscriptType] = ["response", "result", 0, "status_data", 0, "reward"]
                    print(json[pathResult].string ?? "-")
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func CheckResultAPI(_ payload: Parameters) {
        AF.request(
            "https://www.glo.or.th/api/checking/getLotteryResult",
            method: .post,
            parameters: payload,
            encoding: JSONEncoding.prettyPrinted,
            headers: nil)
        .validate(statusCode: 200 ..< 299)
        .responseData { response in
            
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    
                    // First Prize decode to struct
                    let pathFirstPrize: [JSONSubscriptType] = ["response","result","data","first","number",0,"value"]
                    self.result.firstPrize = json[pathFirstPrize].string ?? "-"
                    
                    // 2 Digits decode to struct
                    let pathTwoDigitSuffix: [JSONSubscriptType] = ["response","result","data","last2","number",0,"value"]
                    self.result.twoDigitsSuffix = json[pathTwoDigitSuffix].string ?? "-"
                    
                    // 3 Digits Prefix clear and decode to struct
                    self.result.threeDigitsPrefix.removeAll(keepingCapacity: true)
                    
                    for i in 0...1 {
                        let pathThreeDigitPrefix: [JSONSubscriptType] = ["response","result","data","last3f","number",i,"value"]
                        self.result.threeDigitsPrefix.append(json[pathThreeDigitPrefix].string ?? "-")
                    }
                    
                    // 3 Digits Suffix clear and decode to struct
                    self.result.threeDigitsSuffix.removeAll(keepingCapacity: true)
                    
                    for i in 0...1 {
                        let pathThreeDigitSuffix: [JSONSubscriptType] = ["response","result","data","last3b","number",i,"value"]
                        self.result.threeDigitsSuffix.append(json[pathThreeDigitSuffix].string ?? "-")
                    }
                    
                    // First Prize Nieghbors clear and decode to struct
                    self.result.firstPrizeNeighbors.removeAll(keepingCapacity: true)
                    
                    for i in 0...1 {
                        let pathFirstPrizeNeighbors: [JSONSubscriptType] = ["response","result","data","near1","number",i,"value"]
                        self.result.firstPrizeNeighbors.append(json[pathFirstPrizeNeighbors].string ?? "-")
                    }
                    
                    // Second Prize clear and decode to struct
                    self.result.secondPrize.removeAll(keepingCapacity: true)
                    
                    for i in 0...4 {
                        let pathSecondPrize: [JSONSubscriptType] = ["response","result","data","second","number",i,"value"]
                        self.result.secondPrize.append(json[pathSecondPrize].string ?? "-")
                    }
                    
                    // Third Prize clear and decode to struct
                    self.result.thirdPrize.removeAll(keepingCapacity: true)
                    
                    for i in 0...9 {
                        let pathThirdPrize: [JSONSubscriptType] = ["response","result","data","third","number",i,"value"]
                        self.result.thirdPrize.append(json[pathThirdPrize].string ?? "-")
                    }
                    
                    // Fourth Prize clear and decode to struct
                    self.result.fourthPrize.removeAll(keepingCapacity: true)
                    
                    for i in 0...49 {
                        let pathFourthPrize: [JSONSubscriptType] = ["response","result","data","fourth","number",i,"value"]
                        self.result.fourthPrize.append(json[pathFourthPrize].string ?? "-")
                    }
                    
                    // Fifth Prize clear and decode to struct
                    self.result.fifthPrize.removeAll(keepingCapacity: true)
                    
                    for i in 0...99 {
                        let pathFifthPrize: [JSONSubscriptType] = ["response","result","data","fifth","number",i,"value"]
                        self.result.fifthPrize.append(json[pathFifthPrize].string ?? "-")
                    }
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
            
        }
    }
}
