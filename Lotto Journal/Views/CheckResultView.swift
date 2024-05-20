//
//  CheckLotteryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct CheckResultView: View {
    
    let dateReq = RequestDate(date: "16", month: "05", year: "2024")
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "magnifyingglass")
                    .font(.largeTitle)
                    .foregroundColor(.teal)
                Text("Check Result")
            }
            .navigationTitle("Check Result")
        }
        .onAppear(perform: {
            APICall(dateReq.params)
        })
    }
    
    func APICall(_ payload: Parameters) {
        AF.request(
            "https://www.glo.or.th/api/checking/getLotteryResult",
            method: .post,
            parameters: payload,
            encoding: JSONEncoding.default,
            headers: nil)
        .validate(statusCode: 200 ..< 299)
        .responseData { response in
            let json = try? JSON(data: response.data!)
            let path: [JSONSubscriptType] = ["response","result","data","first","number",0,"value"]
            print(json![path].string!)
        }
        
    }
}

#Preview {
    CheckResultView()
}
