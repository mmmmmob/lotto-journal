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
    let date: Date
    @State var isSearchDone: Bool = false
    @State var isDateCorrect: Bool = true
    
    var body: some View {
        VStack {
            if text.count < 6 {
                Spacer()
                Image(systemName: isDateCorrect ? "1.magnifyingglass" : "xmark.circle")
                    .font(.system(size: 70))
                    .foregroundStyle(isDateCorrect ? Color.secondary : Color.red)
                if isDateCorrect {
                    Text("Enter lottery number for\n\(date.formatted(date: .complete, time: .omitted))")
                        .multilineTextAlignment(.center)
                        .font(.title2).bold()
                } else {
                    Text("Date incorrect")
                        .font(.title2).bold()
                    Text("Check your chosen draw date again")
                        .font(.system(.title3, weight: .light))
                }
                Spacer()
            } else if isDateCorrect {
                Spacer()
                if viewModel.result.fetchNumberStatus == 200 && !viewModel.userPrizeResult.isEmpty {
                    Text("🎉")
                        .font(.system(size: 80))
                    Text("Yay! You won!")
                        .font(.system(.title3, weight: .light))
                    VStack {
                        ForEach(viewModel.userPrizeResult, id: \.self) { result in
                            switch result {
                            case Prize.first.stringPrize:
                                HStack {
                                    Text("First Prize")
                                    Text("฿6,000,000")
                                }
                            case Prize.second.stringPrize:
                                HStack {
                                    Text("Second Prize")
                                    Text("฿200,000")
                                }
                            case Prize.third.stringPrize:
                                HStack {
                                    Text("Third Prize")
                                    Text("฿80,000")
                                }
                            case Prize.fourth.stringPrize:
                                HStack {
                                    Text("Fourth Prize")
                                    Text("฿40,000")
                                }
                            case Prize.firstNB.stringPrize:
                                HStack {
                                    Text("First Prize Neighbors")
                                    Text("฿100,000")
                                }
                            case Prize.threePre.stringPrize:
                                HStack {
                                    Text("Three Digits Prefix")
                                    Text("฿4,000")
                                }
                            case Prize.threeSuf.stringPrize:
                                HStack {
                                    Text("Three Digits Suffix")
                                    Text("฿4,000")
                                }
                            case Prize.twoSuf.stringPrize:
                                HStack {
                                    Text("Two Digits Suffix")
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
                }
                else if viewModel.result.fetchNumberStatus == 200 && viewModel.userPrizeResult.isEmpty {
                    Text("😢")
                        .font(.system(size: 80))
                    Text("Sorry, you didn't win...")
                        .font(.title2).bold()
                }
                else if viewModel.result.fetchNumberStatus == 500 && viewModel.userPrizeResult.isEmpty {
                    Text("👨🏻‍💻")
                        .font(.system(size: 80))
                    Text("The results are in...")
                        .font(.title2).bold()
                }
                Spacer()
            } else if !isDateCorrect {
                Spacer()
                Text("😒")
                    .font(.system(size: 80))
                Text("Date incorrect")
                    .font(.largeTitle).bold()
                    .foregroundStyle(.red)
                Text("Check your chosen draw date again")
                    .font(.system(.title3, weight: .light))
                Spacer()
            }
            else {
                Spacer()
                ProgressView("Loading...")
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .sensoryFeedback(.success, trigger: isSearchDone)
        .sensoryFeedback(.error, trigger: isDateCorrect)
        .onChange(of: text) { _, newText in
            if newText.count == 6 && isDateCorrect == true {
                viewModel.numberSearchAPI(searchNum: newText, date: date.periodDate)
                isSearchDone.toggle()
            } else if newText.count < 6 {
                viewModel.result.userResult.removeAll()
                viewModel.result.fetchNumberStatus = 500
                viewModel.drawDateResultAPI(date.params)
                if viewModel.result.checkResultStatus == "Unsuccess" {
                    isDateCorrect = false
                } else { isDateCorrect = true }
            }
        }
        .onChange(of: date) {
            isDateCorrect = true
            viewModel.result.checkResultStatus = ""
        }
    }
}

#Preview {
    @Previewable @State var text = "123456"
    let date = Date()
    ResultView(text: $text, date: date)
}
