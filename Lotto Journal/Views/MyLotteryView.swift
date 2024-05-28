//
//  ContentView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI
import SwiftData

struct MyLotteryView: View {
    
    @Query(sort: \DrawDate.date, order: .reverse) private var dates: [DrawDate]
    @Query private var lotteries: [Lottery]
    @Environment(\.modelContext) private var modelContext
    @State var isAddding: Bool = false
    @State var searchNumber: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dates) { date in
                    if date.lotteries.count > 0 {
                        Section {
                            ForEach(date.lotteries) { lottery in
                                HStack {
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
                            Text(date.date.periodDate)
                        }
                        .headerProminence(.increased)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Lotter\(lotteries.count > 1 ? "ies" : "y")")
            .toolbar {
                if !lotteries.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddding.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $isAddding) {
                AddMyLotteryView()
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    MyLotteryView()
        .modelContainer(for: DrawDate.self, inMemory: true)
}
