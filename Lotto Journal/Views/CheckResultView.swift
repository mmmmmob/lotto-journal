//
//  CheckLotteryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import SwiftUI

struct CheckResultView: View {
    
    @StateObject var viewModel = CheckResultViewModel()
    @State var text: String = ""
    @State var date: Date = Date()
    @State var isSearchDone: Bool = true
    
    var body: some View {
        NavigationStack {
            ResultView(text: $text, date: $date, isSearchDone: $isSearchDone)
                .searchable(text: $text, prompt: "Check Your Lottery")
                .keyboardType(.numberPad)
            ScrollView {
                VStack {
                    DatePicker("🗓️ Draw Date", selection: $date, in: viewModel.firstDateOfResult...Date()
                               , displayedComponents: .date)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    Spacer()
                    Button("🗓️ Latest Draw") {
                        viewModel.latestResultAPI()
                        if let latestResultDate = viewModel.result.latestResultDate.toDate() {
                            date = latestResultDate
                        }
                    }
                }
                Spacer()
                if viewModel.result.fetchLatestStatus == 500 {
                    ProgressView("Loading...")
                        .offset(x: 0, y:200)
                } else if viewModel.result.fetchLatestStatus == 200 && viewModel.result.firstPrize != "-" {
                    VStack {
                        VStack {
                            PrizeHeaderView(prize: "First Prize", amount: "6,000,000")
                            PrizeNumberView(number: viewModel.result.firstPrize)
                        }
                        VStack {
                            PrizeHeaderView(prize: "Three Digits Prefix", amount: "4,000")
                            HStack {
                                ForEach(viewModel.result.threeDigitsPrefix.indices, id: \.self) { index in
                                    PrizeNumberView(number: viewModel.result.threeDigitsPrefix[index])
                                }
                            }
                        }
                        VStack {
                            PrizeHeaderView(prize: "Three Digits Suffix", amount: "4,000")
                            HStack {
                                ForEach(viewModel.result.threeDigitsSuffix.indices, id: \.self) { index in
                                    PrizeNumberView(number: viewModel.result.threeDigitsSuffix[index])
                                }
                            }
                        }
                        VStack {
                            PrizeHeaderView(prize: "Two Digits Suffix", amount: "2,000")
                            PrizeNumberView(number: viewModel.result.twoDigitsSuffix)
                        }
                        VStack {
                            PrizeHeaderView(prize: "First Price Neighbors", amount: "100,000")
                            HStack {
                                ForEach(viewModel.result.firstPrizeNeighbors.indices, id: \.self) { index in
                                    PrizeNumberView(number: viewModel.result.firstPrizeNeighbors[index])
                                }
                            }
                        }
                        VStack {
                            PrizeHeaderView(prize: "Second Prize", amount: "200,000")
                            PrizeNumberMultipleView(number: viewModel.result.secondPrize)
                        }
                        VStack {
                            PrizeHeaderView(prize: "Third Prize", amount: "80,000")
                            PrizeNumberMultipleView(number: viewModel.result.thirdPrize)
                        }
                        VStack {
                            PrizeHeaderView(prize: "Fourth Prize", amount: "40,000")
                            PrizeNumberMultipleView(number: viewModel.result.fourthPrize)
                        }
                        VStack {
                            PrizeHeaderView(prize: "Fifth Prize", amount: "20,000")
                            PrizeNumberMultipleView(number: viewModel.result.fifthPrize)
                        }
                    }
                } else {
                    VStack {
                        Text("🚧")
                            .font(.system(size: 80))
                        Text("No result available")
                            .font(.system(.title3, weight: .light))
                        Text("Please select another date")
                            .font(.title2).bold()
                    }
                    .offset(x: 0, y:60)
                    Spacer()
                }
            }
            .navigationTitle("Prize Result")
            .padding(.horizontal)
        }
        .onAppear(perform: {
            viewModel.latestResultAPI()
        })
        .onChange(of: viewModel.result.latestResultDate) {
            if let latestResultDate = viewModel.result.latestResultDate.toDate() {
                date = latestResultDate
            }
        }
        .onChange(of: date) {
            viewModel.checkResultAPI(date.params)
        }
    }
}

#Preview {
    CheckResultView(isSearchDone: true)
}
