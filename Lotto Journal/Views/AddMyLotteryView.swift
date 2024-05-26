//
//  AddMyLotteryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 26.05.2024.
//

import SwiftUI
import OTPView

struct AddMyLotteryView: View {
        
    @StateObject private var apiCall = CheckResultViewModel()

    @Environment(\.dismiss) var isDismiss
    @State var number: String = ""
    @State var drawDate: Date = Date()
    @State var amountBought: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                OtpView(activeIndicatorColor: Color.teal, inactiveIndicatorColor: Color.gray, length: 6, doSomething: { numbers in
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
                DatePicker("🗓️  Draw Date", selection: $drawDate, displayedComponents: .date)
                    .bold()
                Button {
                    print(number)
                    print(drawDate.params)
                    print(amountBought)
                    isDismiss()
                } label: {
                    Text("Add")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.teal)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle)
                .padding(.top)
            }
            .padding(.horizontal)
            .keyboardType(.numberPad)
            .navigationTitle("Add Lottery")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Cancel") {
                    isDismiss()
                }
                .foregroundStyle(Color.red)
            }
        }
        .onAppear(perform: {
            apiCall.latestResultAPI()
        })
        .onChange(of: apiCall.result.latestResultDate) {
            if let latestResultDate = apiCall.result.latestResultDate.toDate() {
                drawDate = latestResultDate.addingTimeInterval(1_382_400)
            }
        }
    }
}

#Preview {
    AddMyLotteryView(amountBought: 1)
}
