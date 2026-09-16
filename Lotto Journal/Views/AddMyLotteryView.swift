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
    
    @State private var apiCall = CheckResultViewModel()
    
    @Query private var listedDrawDate: [DrawDate]
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var isDismiss
    
    @State private var number: String = ""
    @State private var amountBought: Int = 1
    @State private var drawDate = Date()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 6-digit lottery number input
                    OtpView(
                        activeIndicatorColor: Color.customBlue,
                        inactiveIndicatorColor: Color.secondary.opacity(0.3),
                        length: 6,
                        doSomething: { numbers in
                            number = numbers
                        }
                    )
                    .padding(.vertical, 8)
                    
                    // Form controls wrapped in a Liquid Glass card
                    VStack(spacing: 14) {
                        Stepper(value: $amountBought, in: 1...100) {
                            HStack {
                                Label("Amount Bought", systemImage: "number")
                                    .font(.body.weight(.medium))
                                Spacer()
                                Text("\(amountBought)")
                                    .font(.body.monospacedDigit().weight(.semibold))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background(Color.secondary.opacity(0.12), in: Capsule())
                                    .padding(.trailing, 4)
                            }
                        }
                        
                        Divider()
                        
                        DatePicker(selection: $drawDate, displayedComponents: .date) {
                            Label("Draw Date", systemImage: "calendar")
                                .font(.body.weight(.medium))
                        }
                    }
                    .padding(16)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.45), Color.primary.opacity(0.08)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    }
                    .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 3)
                    
                    // Add button styled with Vibrant Glass
                    Button {
                        addNewLottery()
                        isDismiss()
                    } label: {
                        Text("Add")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .foregroundStyle(Color.customWhite)
                            .background {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(
                                        number.count == 6
                                        ? LinearGradient(
                                            colors: [Color.customBlue.opacity(0.92), Color.customBlue],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                        : LinearGradient(
                                            colors: [Color.gray.opacity(0.35), Color.gray.opacity(0.25)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .strokeBorder(
                                        LinearGradient(
                                            colors: [Color.white.opacity(0.45), Color.white.opacity(0.12)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            }
                            .shadow(color: number.count == 6 ? Color.customBlue.opacity(0.28) : .clear, radius: 8, x: 0, y: 4)
                    }
                    .disabled(number.count != 6)
                    .animation(.easeInOut(duration: 0.2), value: number.count == 6)
                    .padding(.top, 4)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 20)
            }
            .scrollBounceBehavior(.basedOnSize)
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
