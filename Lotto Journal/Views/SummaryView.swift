//
//  SummaryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import SwiftUI
import SwiftData

struct SummaryView: View {
    
    @Query private var drawDates: [DrawDate]
    @Query private var lotteries: [Lottery]
    
    // Computed Variables for SummaryView
    var totalSpending: Int {
        var total: Int = 0
        for drawDate in drawDates {
            total += drawDate.totalInvestment
        }
        return total
    }
    
    var totalPrizeWon: Int {
        var total: Int = 0
        for drawDate in drawDates {
            total += drawDate.totalWon
        }
        return total
    }
    
    var totalPL: Int {
        return totalPrizeWon - totalSpending
    }
    
    var chanceOfWinning: Double {
        guard !lotteries.isEmpty else { return 0.0 }
        let numberOfLotteryBought = Double(lotteries.count)
        let numberOfLotteryWon = Double(lotteries.filter({ $0.status == .doesWon }).count)
        return (numberOfLotteryWon / numberOfLotteryBought) * 100
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if lotteries.isEmpty {
                    ContentUnavailableView(
                        "Summary Unavailable",
                        systemImage: "chart.bar.xaxis",
                        description: Text("Keep using to track your progress")
                    )
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            // Total Profit / Loss Card
                            VStack(alignment: .trailing, spacing: 8) {
                                Text("📈 Total Profit / Loss")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.customWhite.opacity(0.85))
                                Text("฿\(totalPL.delimiter)")
                                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                    .foregroundStyle(totalPL > 0 ? Color.customGreen : Color.red)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(24)
                            .background {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.customBlue.opacity(0.92), Color.customBlue],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .strokeBorder(
                                        LinearGradient(
                                            colors: [Color.white.opacity(0.45), Color.white.opacity(0.12)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            }
                            .shadow(color: Color.customBlue.opacity(0.28), radius: 12, x: 0, y: 6)
                            
                            // Chance of Winning Card
                            VStack(alignment: .trailing, spacing: 8) {
                                Text("⛅️ Chance of Winning")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.customWhite.opacity(0.85))
                                Text(chanceOfWinning / 100, format: .percent.precision(.fractionLength(2)))
                                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                    .foregroundStyle(chanceOfWinning < 50 ? Color.red : Color.customGreen)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(24)
                            .background {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.customBlue.opacity(0.92), Color.customBlue],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .strokeBorder(
                                        LinearGradient(
                                            colors: [Color.white.opacity(0.45), Color.white.opacity(0.12)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            }
                            .shadow(color: Color.customBlue.opacity(0.28), radius: 12, x: 0, y: 6)
                            
                            // Spending & Prize Won widgets
                            HStack(spacing: 12) {
                                SummaryWidgetHalfView(numberToShow: totalSpending, headerText: String(localized: "💸 Total Spending"))
                                SummaryWidgetHalfView(numberToShow: totalPrizeWon, headerText: String(localized: "🏆 Total Prize Won"))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
            }
            .navigationTitle("Summary")
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Lottery.self, configurations: config)
    
    for _ in 1..<5 {
        let lottery = Lottery(number: "344555", amount: 2, status: .doesWon, drawDate: DrawDate(date: Date.now), amountWon: 2000)
        container.mainContext.insert(lottery)
    }
    
    return SummaryView()
        .modelContainer(container)
}
