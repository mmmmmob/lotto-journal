//
//  ContentView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI
import SwiftData

struct MyLotteryView: View {
    
    @Query(sort: \Lottery.amount) private var lotteries: [Lottery]
    @State var isAddding: Bool = false
    
    var body: some View {
        NavigationStack {
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
                            Text(lottery.status.description)
                                .font(.system(.subheadline, weight: .light))
                        }
                    }
                }
            }
            .navigationTitle("My Lotter\(lotteries.count > 1 ? "ies" : "y")")
            .toolbar {
                Button(action: {
                    isAddding.toggle()
                }, label: {
                        Image(systemName: "plus")
                })
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
