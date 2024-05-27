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
    
    private var searchResult: [Lottery] {
        if searchNumber.isEmpty {
            return lotteries
        } else {
            return lotteries.filter {
                $0.number.contains(searchNumber)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if lotteries.isEmpty {
                    ContentUnavailableView("Enter your first lottery", systemImage: "wand.and.stars")
                } else {
                    List {
                        ForEach(searchResult) { number in
                            HStack {
                                HStack {
                                    Text(number.number)
                                        .font(.system(.headline, design: .monospaced, weight: .semibold))
                                        .tracking(7)
                                    if number.amount > 1 {
                                        Text("x \(number.amount)")
                                            .font(.system(.caption, weight: .thin))
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                Spacer()
                                HStack(spacing: 5) {
                                    number.tagSymbol
                                        .foregroundStyle(number.tagColor)
                                        .imageScale(.small)
                                    Text(number.status.description)
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
