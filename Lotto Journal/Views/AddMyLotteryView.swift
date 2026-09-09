//
//  AddMyLotteryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 26.05.2024.
//

import SwiftUI
import SwiftData
import OTPView

struct AddMyLotteryView: View {
    
    @StateObject private var apiCall = CheckResultViewModel()
    
    @Query private var listedDrawDate: [DrawDate]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var isDismiss
    
    @State private var number: String = ""
    @State private var amountBought: Int = 1
    @State private var drawDate = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                OtpView(activeIndicatorColor: Color.accentColor, inactiveIndicatorColor: Color.gray, length: 6, doSomething: { numbers in
                    number = numbers
                })
                .padding(.bottom)
                HStack {
                    Stepper(
                        value: $amountBought,
                        in: 1...100
                    ) {
                        HStack {
                            Text("🔢  Amount Bought")
                                .bold()
                            Spacer()
                            Text("\(amountBought)")
                                .padding(.trailing)
                        }
                    }
                }
                DatePicker("🗓️ Draw Date", selection: $drawDate, displayedComponents: .date)
                    .bold()
                Button {
                    addNewLottery()
                    isDismiss()
                } label: {
                    Text("Add")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(number.isEmpty)
                .tint(.accentColor)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle)
                .padding(.top)
            }
            .padding(.horizontal)
            .keyboardType(.numberPad)
            .navigationTitle("Add Lottery")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        isDismiss()
                    }
                    .foregroundStyle(.red)
                }
            }
        }
        .onAppear {
            apiCall.latestResultAPI()
        }
        .onChange(of: apiCall.result.latestResultDate) { _, newLatestDate in
            if let latestResultDate = newLatestDate.toDate() {
                drawDate = latestResultDate.upcomingDrawDate
            }
        }
    }
    
    private func addNewLottery() {
        let newDrawDate = DrawDate(date: drawDate)
        let newLottery = Lottery(number: number, amount: amountBought)
        
        if !listedDrawDate.contains(where: {$0.date == drawDate}) {
            modelContext.insert(newDrawDate)
            newDrawDate.lotteries.append(newLottery)
        } else {
            let filteredDrawDate = listedDrawDate.filter({$0.date == drawDate})
            filteredDrawDate[0].lotteries.append(newLottery)
        }
    }
}

#Preview {
    AddMyLotteryView()
}
