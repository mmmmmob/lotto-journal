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
    @State var date = Date()
    var number: [String] = ["918273", "192837", "928374", "198273", "837462", "564738","918273", "192837", "928374", "198273"]
    var number2: [String] = ["483927", "194820", "583726", "492837", "918273", "192837", "928374", "198273", "837462", "564738",
                             "293847", "182736", "918374", "637281", "271635", "482736", "564829", "192837", "182736", "918273",
                             "281736", "462837", "364728", "728193", "837261", "293847", "192736", "182736", "837462", "192837",
                             "918273", "637281", "293847", "284736", "918273", "182736", "637281", "837462", "293847", "182736",
                             "918273", "293847", "182736", "928374", "192837", "837462", "193847", "192837", "293847", "182736"
    ]
    
    var body: some View {
        NavigationStack {
            DatePicker("🗓️ Draw Date", selection: $date
                       , displayedComponents: .date)
            .padding(.horizontal)
            Spacer()
            ScrollView {
                VStack {
                    VStack {
                        PrizeHeaderView(prize: "First Prize", amount: "6,000,000")
                        PrizeNumberView(number: "456777")
                    }
                    VStack {
                        PrizeHeaderView(prize: "Three Digits Prefix", amount: "4,000")
                        HStack {
                            PrizeNumberView(number: "333")
                            PrizeNumberView(number: "333")
                        }
                    }
                    VStack {
                        PrizeHeaderView(prize: "Three Digits Suffix", amount: "4,000")
                        HStack {
                            PrizeNumberView(number: "333")
                            PrizeNumberView(number: "333")
                        }
                    }
                    VStack {
                        PrizeHeaderView(prize: "Two Digits Suffix", amount: "2,000")
                        PrizeNumberView(number: "60")
                    }
                    VStack {
                        PrizeHeaderView(prize: "First Price Neighbors", amount: "100,000")
                        HStack {
                            PrizeNumberView(number: "456776")
                            PrizeNumberView(number: "456778")
                        }
                    }
                    VStack {
                        PrizeHeaderView(prize: "Second Prize", amount: "200,000")
                        PrizeNumberMultipleView(number: number)
                    }
                    VStack {
                        PrizeHeaderView(prize: "Third Prize", amount: "80,000")
                        PrizeNumberMultipleView(number: number2)
                    }
                    VStack {
                        PrizeHeaderView(prize: "Fourth Prize", amount: "40,000")
                        PrizeNumberMultipleView(number: number2)
                    }
                    VStack {
                        PrizeHeaderView(prize: "Fifth Prize", amount: "20,000")
                        PrizeNumberMultipleView(number: number2)
                    }
                }
                .navigationTitle("Check Result")
            }
            .padding(.horizontal)
            .searchable(text: $text)
            .onChange(of: date) {
                viewModel.CheckResultAPI(date.params)
            }
        }
        
    }
}

#Preview {
    CheckResultView()
}
