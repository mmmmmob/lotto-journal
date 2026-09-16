//
//  CheckLotteryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import SwiftUI

struct CheckResultView: View {
    
    @StateObject var viewModel = CheckResultViewModel()
    @Binding var date: Date
    
    init(date: Binding<Date> = .constant(Date())) {
        self._date = date
    }
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 24) {
                        Color.clear
                            .frame(height: 0)
                            .id("top")
                        
                        // Date picker and Latest Draw control
                        VStack(spacing: 12) {
                            DatePicker(
                                "Draw Date",
                                selection: $date,
                                in: viewModel.firstDayOfResult...(viewModel.result.latestResultDate.toDate() ?? Date()),
                                displayedComponents: .date
                            )
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            
                            Button {
                                viewModel.latestResultAPI()
                                if let latestResultDate = viewModel.result.latestResultDate.toDate() {
                                    date = latestResultDate
                                }
                            } label: {
                                Label("Latest Draw", systemImage: "calendar.badge.clock")
                                    .font(.subheadline.weight(.semibold))
                            }
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            //.tint(Color.customBlue)
                        }
                        .padding(.top, 4)
                        
                        if viewModel.result.fetchLatestStatus == 500 {
                            ProgressView("Loading...")
                                .padding(.top, 40)
                        } else if viewModel.result.fetchLatestStatus == 200 && viewModel.result.firstPrize != "-" {
                            VStack(spacing: 20) {
                                // First Prize
                                VStack(alignment: .leading, spacing: 6) {
                                    PrizeHeaderView(prize: String(localized: "First Prize"), amount: "6,000,000")
                                    PrizeNumberView(number: viewModel.result.firstPrize)
                                }
                                
                                // Three Digits Prefix
                                VStack(alignment: .leading, spacing: 6) {
                                    PrizeHeaderView(prize: String(localized: "Three Digits Prefix"), amount: "4,000")
                                    HStack(spacing: 12) {
                                        ForEach(viewModel.result.threeDigitsPrefix.indices, id: \.self) { index in
                                            PrizeNumberView(number: viewModel.result.threeDigitsPrefix[index])
                                        }
                                    }
                                }
                                
                                // Three Digits Suffix
                                VStack(alignment: .leading, spacing: 6) {
                                    PrizeHeaderView(prize: String(localized: "Three Digits Suffix"), amount: "4,000")
                                    HStack(spacing: 12) {
                                        ForEach(viewModel.result.threeDigitsSuffix.indices, id: \.self) { index in
                                            PrizeNumberView(number: viewModel.result.threeDigitsSuffix[index])
                                        }
                                    }
                                }
                                
                                // Two Digits Suffix
                                VStack(alignment: .leading, spacing: 6) {
                                    PrizeHeaderView(prize: String(localized: "Two Digits Suffix"), amount: "2,000")
                                    PrizeNumberView(number: viewModel.result.twoDigitsSuffix)
                                }
                                
                                // First Prize Neighbors
                                VStack(alignment: .leading, spacing: 6) {
                                    PrizeHeaderView(prize: String(localized: "First Prize Neighbors"), amount: "100,000")
                                    HStack(spacing: 12) {
                                        ForEach(viewModel.result.firstPrizeNeighbors.indices, id: \.self) { index in
                                            PrizeNumberView(number: viewModel.result.firstPrizeNeighbors[index])
                                        }
                                    }
                                }
                                
                                // Second Prize
                                VStack(alignment: .leading, spacing: 6) {
                                    PrizeHeaderView(prize: String(localized: "Second Prize"), amount: "200,000")
                                    PrizeNumberMultipleView(number: viewModel.result.secondPrize)
                                }
                                
                                // Third Prize
                                VStack(alignment: .leading, spacing: 6) {
                                    PrizeHeaderView(prize: String(localized: "Third Prize"), amount: "80,000")
                                    PrizeNumberMultipleView(number: viewModel.result.thirdPrize)
                                }
                                
                                // Fourth Prize
                                VStack(alignment: .leading, spacing: 6) {
                                    PrizeHeaderView(prize: String(localized: "Fourth Prize"), amount: "40,000")
                                    PrizeNumberMultipleView(number: viewModel.result.fourthPrize)
                                }
                                
                                // Fifth Prize
                                VStack(alignment: .leading, spacing: 6) {
                                    PrizeHeaderView(prize: String(localized: "Fifth Prize"), amount: "20,000")
                                    PrizeNumberMultipleView(number: viewModel.result.fifthPrize)
                                }
                            }
                        } else {
                            ContentUnavailableView(
                                "No Result Available",
                                systemImage: "calendar.badge.exclamationmark",
                                description: Text("Please select another date")
                            )
                            .padding(.top, 20)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 60)
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
                .onChange(of: date) { _, newDate in
                    withAnimation {
                        proxy.scrollTo("top", anchor: .top)
                    }
                    viewModel.drawDateResultAPI(newDate.params)
                }
            }
            .navigationTitle("Prize Result")
        }
        .onAppear {
            viewModel.latestResultAPI()
        }
        .onChange(of: viewModel.result.latestResultDate) { _, newLatestDate in
            if let latestResultDate = newLatestDate.toDate() {
                date = latestResultDate
            }
        }
    }
}

#Preview {
    @Previewable @State var date = Date()
    CheckResultView(date: $date)
}
