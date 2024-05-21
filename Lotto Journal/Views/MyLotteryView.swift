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
    @Query private var items: [MyLotto]

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    
                    let testDate = item.timestamp.nameOfMonth + " " + item.timestamp.dateSingle + ", " + item.timestamp.year
                    
                    NavigationLink {
                        Text("Item at \(testDate)")
                    } label: {
                        Text("\(testDate)")
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
            let newItem = MyLotto(timestamp: Date())
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
        .modelContainer(for: MyLotto.self, inMemory: true)
}
