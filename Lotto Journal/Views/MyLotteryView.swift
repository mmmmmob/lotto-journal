//
//  ContentView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI
import SwiftData

struct MyLotteryView: View {
    
    @Query(sort: \Lottery.amount, order: .reverse) private var lotteries: [Lottery]
    @Environment(\.modelContext) private var modelContext
    @State var isAddding: Bool = false
    @State var searchNumber: String = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if lotteries.isEmpty {
                    ContentUnavailableView("Enter your first lottery", systemImage: "wand.and.stars")
                } else {
                    List {
                        ForEach(lotteries) { lottery in
                            HStack {
                                HStack {
                                    Text(lottery.number)
                                        .font(.system(.headline, design: .monospaced, weight: .semibold))
                                        .tracking(7)
                                    if lottery.amount > 1 {
                                        Text("x \(lottery.amount)")
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
                                let lottery = lotteries[index]
                                modelContext.delete(lottery)
                            }
                        })
                    }
                    .listStyle(.plain)
                }
            }
            .searchable(text: $searchNumber)
            .keyboardType(.numberPad)
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
                        Image(systemName: "plus.circle.fill")
                    })
                }
            }
            .sheet(isPresented: $isAddding) {
                AddMyLotteryView(amountBought: 1)
                    .presentationDetents([.medium])
            }
        }
    }
}

#Preview {
    MyLotteryView()
        .modelContainer(for: Lottery.self, inMemory: true)
}
