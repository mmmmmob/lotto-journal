//
//  ContentView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI
import SwiftData

struct MyLotteryView: View {
    
    @State var isAddding: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "123.rectangle")
                    .font(.largeTitle)
                    .foregroundColor(.teal)
                    .padding(.bottom)
                Text("My Lottery")
            }
            .navigationTitle("My Lottery")
            .toolbar {
                Button(action: {
                    isAddding.toggle()
                }, label: {
                    Image(systemName: "plus")
                })
            }
            .sheet(isPresented: $isAddding, content: {
                AddMyLotteryView(amountBought: 1)
            })
        }
    }
}

#Preview {
    MyLotteryView()
}
