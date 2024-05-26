//
//  AddMyLotteryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 26.05.2024.
//

import SwiftUI
import OTPView

struct AddMyLotteryView: View {
    
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
                            Text("🔢 Amount Bought")
                            Spacer()
                            Text("\(amountBought)")
                                .bold()
                                .padding(.trailing)
                        }
                    }
                }
                DatePicker("🗓️ Draw Date", selection: $drawDate, displayedComponents: .date)
                Button {
                    print(number)
                    print(drawDate.params)
                    print(amountBought)
                    isDismiss()
                } label: {
                    Text("Add")
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
        
    }
}

#Preview {
    AddMyLotteryView(amountBought: 1)
}
