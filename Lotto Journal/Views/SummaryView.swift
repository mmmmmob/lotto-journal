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
        var percentage: Double = 0.00
        
        let numberOfLotteryBought = Double(lotteries.count)
        let numberOfLotteryWon = Double(lotteries.filter({$0.status == .doesWon}).count)
        
        percentage = (numberOfLotteryWon / numberOfLotteryBought) * 100
        
        return percentage
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
                }
                else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.accentColor.opacity(0.7))
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .overlay {
                            VStack(alignment: .trailing) {
                                Text("📈 Total Profit / Loss")
                                    .font(.system(.caption, design: .default, weight: .regular))
                                    .foregroundStyle(.primary)
                                Text("฿\(totalPL.delimiter)")
                                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                    .foregroundStyle(totalPL > 0 ? .green : .red)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundStyle(.white)
                            .padding(40)
                        }
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.accentColor.opacity(0.7))
                        .frame(maxWidth: .infinity, maxHeight: 150)
                        .padding(.horizontal)
                        .overlay {
                            VStack(alignment: .trailing) {
                                Text("⛅️ Chance of Winning")
                                    .font(.system(.caption, design: .default, weight: .regular))
                                    .foregroundStyle(.primary)
                                Text("\(chanceOfWinning, specifier: "%.2f")%")
                                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                    .foregroundStyle(chanceOfWinning < 50 ? .red : .green)
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .foregroundStyle(.white)
                            .padding(40)
                        }
                    HStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: 150)
                            .overlay {
                                VStack(alignment: .trailing) {
                                    Text("💸 Total Spending")
                                        .font(.system(.caption, design: .default, weight: .regular))
                                        .foregroundStyle(.primary)
                                    Text("฿\(totalSpending.delimiter)")
                                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                        .foregroundStyle(.white)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            }
                            .padding(.leading)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor.opacity(0.7))
                            .frame(maxWidth: .infinity, maxHeight: 150)
                            .overlay {
                                VStack(alignment: .trailing) {
                                    Text("🏆 Total Prize Won")
                                        .font(.system(.caption, design: .default, weight: .regular))
                                        .foregroundStyle(.primary)
                                    Text("฿\(totalPrizeWon.delimiter)")
                                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                        .foregroundStyle(.white)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            }
                            .padding(.trailing)
                    }
                    Spacer()
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
