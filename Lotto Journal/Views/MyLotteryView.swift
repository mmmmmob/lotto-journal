//
//  ContentView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI
import SwiftData

struct MyLotteryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Lottery]

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("My Lotter\(items.count >=  2 ? "ies" : "y")")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Lottery(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    MyLotteryView()
        .modelContainer(for: Lottery.self, inMemory: true)
}