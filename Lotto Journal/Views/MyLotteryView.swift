//
//  ContentView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI
import SwiftData

struct MyLotteryView: View {
    
    @StateObject private var firstAPICall = CheckResultViewModel()
    
    @Query(sort: \DrawDate.date, order: .reverse) private var dates: [DrawDate]
    @Query private var lotteries: [Lottery]
    @Environment(\.modelContext) private var modelContext
    @State var isAdding: Bool = false
    @State var searchNumber: String = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if dates.isEmpty || lotteries.isEmpty {
                    ContentUnavailableView(
                        "No Lottery to Display",
                        systemImage: "plus.rectangle.on.rectangle",
                        description: Text("Tap \(Image(systemName: "plus.circle")) above to log your first one")
                    )
                } else {
                    List {
                        ForEach(dates) { date in
                            if date.lotteries.count > 0 {
                                Section {
                                    ForEach(date.lotteries) { lottery in
                                        HStack(alignment: .center) {
                                            HStack {
                                                Text(lottery.number)
                                                    .font(.system(.headline, design: .monospaced, weight: .semibold))
                                                    .tracking(7)
                                                let amountBought = lottery.amount
                                                if amountBought > 1 {
                                                    Text("x \(amountBought)")
                                                        .font(.system(.caption, weight: .thin))
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                            Spacer()
                                            HStack(spacing: 5) {
                                                lottery.tagSymbol
                                                    .foregroundStyle(lottery.tagColor)
                                                    .imageScale(.small)
                                                Text(lottery.status.description)
                                                    .font(.system(.subheadline, weight: .light))
                                            }
                                        }
                                    }
                                    .onDelete(perform: { indexSet in
                                        indexSet.forEach { index in
                                            let lottery = date.lotteries[index]
                                            modelContext.delete(lottery)
                                        }
                                    })
                                } header: {
                                    HStack(alignment: .firstTextBaseline) {
                                        if let latestResultDate = firstAPICall.result.latestResultDate.toDate() {
                                            let upcomingDate = latestResultDate.upcomingDrawDate
                                            if date.date == upcomingDate {
                                                Text("Upcoming Draw")
                                            } else if date.date == latestResultDate {
                                                Text("Latest Draw")
                                            } else {
                                                Text(date.date.fullStringDate)
                                            }
                                        } else {
                                            Text(date.date.fullStringDate) // display fullStringDate while determine date from API
                                        }
                                        Spacer()
                                        HStack(alignment: .center) {
                                            Text("Total investment: ")
                                            ForEach(date.lotteries) { result in
                                                Text("\(result.investmentPerLottery)")
                                            }
                                        }
                                        .font(.system(.caption, design: .default, weight: .light))
                                    }
                                }
                                .headerProminence(.increased)
                            }
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("My Lotter\(lotteries.count > 1 ? "ies" : "y")")
            .toolbar {
                if !lotteries.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAdding.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            }
            .sheet(isPresented: $isAdding) {
                AddMyLotteryView()
                    .presentationDetents([.medium])
            }
        }
        .onAppear(perform: {
            firstAPICall.latestResultAPI()
        })
    }
}

#Preview {
    MyLotteryView()
        .modelContainer(for: DrawDate.self, inMemory: true)
}
