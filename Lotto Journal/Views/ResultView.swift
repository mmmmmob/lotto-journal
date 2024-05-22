//
//  ResultView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 22.05.2024.
//

import SwiftUI

struct ResultView: View {
    
    @StateObject var viewModel = CheckResultViewModel()
    @Environment(\.isSearching) private var isSearching: Bool
    @Binding var text: String
    @Binding var date: Date
    
    var body: some View {
        if isSearching {
            VStack {
                if text.count < 6 {
                    Text("🔍")
                        .font(.system(size: 80))
                    Text("Enter lottery number above")
                        .font(.title2).bold()
                }
                else if viewModel.result.fetchNumberStatus == 200 && viewModel.userPrizeResult.isEmpty {
                    Text("😢")
                        .font(.system(size: 80))
                    Text("Sorry, you didn't win...")
                        .font(.title2).bold()
                } else if viewModel.result.fetchNumberStatus == 200 && !viewModel.userPrizeResult.isEmpty {
                    Text("🎉")
                        .font(.system(size: 80))
                    Text("Yay! You won!")
                        .font(.system(.title3, weight: .light))
                    VStack {
                        ForEach(viewModel.userPrizeResult, id: \.self) { result in
                            switch result {
                            case PrizeList.first.rawValue:
                                HStack {
                                    Text("First Prize")
                                    Text("฿6,000,000")
                                }
                            case PrizeList.second.rawValue:
                                HStack {
                                    Text("Second Prize")
                                    Text("฿200,000")
                                }
                            case PrizeList.third.rawValue:
                                HStack {
                                    Text("Third Prize")
                                    Text("฿80,000")
                                }
                            case PrizeList.fourth.rawValue:
                                HStack {
                                    Text("Fourth Prize")
                                    Text("฿40,000")
                                }
                            case PrizeList.firstNB.rawValue:
                                HStack {
                                    Text("First Prize Neighbors")
                                    Text("฿100,000")
                                }
                            case PrizeList.threePre.rawValue:
                                HStack {
                                    Text("Three Digits Prefix")
                                    Text("฿4,000")
                                }
                            case PrizeList.threeSuf.rawValue:
                                HStack {
                                    Text("Three Digits Suffix")
                                    Text("฿4,000")
                                }
                            case PrizeList.twoSuf.rawValue:
                                HStack {
                                    Text("Two Digits Sufix")
                                    Text("฿2,000")
                                }
                            default:
                                HStack {
                                    Text("Fifth Prize")
                                    Text("฿20,000")
                                }
                            }
                        }
                    }
                    .font(.title2).bold()
                } else {
                    ProgressView("Loading...")
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .frame(height: 500)
            .onChange(of: text) {
                if text.count == 6 {
                    viewModel.result.userResult.removeAll()
                    viewModel.numberSearchAPI(searchNum: text, date: date.periodDate)
                }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    @State var text = "..."
    @State var date = Date()
    return ResultView(text: $text, date: $date)
}
