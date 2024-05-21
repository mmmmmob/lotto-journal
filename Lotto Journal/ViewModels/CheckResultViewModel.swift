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
        let pathTwoDigitSuffix: [JSONSubscriptType] = ["response","result","data","last2","number",0,"value"]
        
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
            
            self.result.twoDigitsSuffix = json![pathTwoDigitSuffix].string ?? "nil"
            
            self.result.threeDigitsPrefix.removeAll(keepingCapacity: true)
            
            for i in 0...1 {
                let pathThreeDigitPrefix: [JSONSubscriptType] = ["response","result","data","last3f","number",i,"value"]
                self.result.threeDigitsPrefix.append(json![pathThreeDigitPrefix].string ?? "nil")
            }
            
            self.result.threeDigitsSuffix.removeAll(keepingCapacity: true)
            
            for i in 0...1 {
                let pathThreeDigitSuffix: [JSONSubscriptType] = ["response","result","data","last3b","number",i,"value"]
                self.result.threeDigitsSuffix.append(json![pathThreeDigitSuffix].string ?? "nil")
            }
            
            self.result.firstPrizeNeighbors.removeAll(keepingCapacity: true)
            
            for i in 0...1 {
                let pathFirstPrizeNeighbors: [JSONSubscriptType] = ["response","result","data","near1","number",i,"value"]
                self.result.firstPrizeNeighbors.append(json![pathFirstPrizeNeighbors].string ?? "nil")
            }
            
            self.result.secondPrize.removeAll(keepingCapacity: true)
            
            for i in 0...4 {
                let pathSecondPrize: [JSONSubscriptType] = ["response","result","data","second","number",i,"value"]
                self.result.secondPrize.append(json![pathSecondPrize].string ?? "nil")
            }
            
            self.result.thirdPrize.removeAll(keepingCapacity: true)
            
            for i in 0...9 {
                let pathThirdPrize: [JSONSubscriptType] = ["response","result","data","third","number",i,"value"]
                self.result.thirdPrize.append(json![pathThirdPrize].string ?? "nil")
            }
            
            self.result.fourthPrize.removeAll(keepingCapacity: true)
            
            for i in 0...49 {
                let pathFourthPrize: [JSONSubscriptType] = ["response","result","data","fourth","number",i,"value"]
                self.result.fourthPrize.append(json![pathFourthPrize].string ?? "nil")
            }
            
            self.result.fifthPrize.removeAll(keepingCapacity: true)
            
            for i in 0...99 {
                let pathFifthPrize: [JSONSubscriptType] = ["response","result","data","fifth","number",i,"value"]
                self.result.fifthPrize.append(json![pathFifthPrize].string ?? "nil")
            }
        }
    }
}
