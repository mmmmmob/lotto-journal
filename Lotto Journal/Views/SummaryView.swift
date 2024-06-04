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
                    Text("Hello, World!")
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
