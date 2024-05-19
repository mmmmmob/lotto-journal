//
//  CheckLotteryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import SwiftUI

struct CheckResultView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "magnifyingglass")
                    .font(.largeTitle)
                    .foregroundColor(.teal)
                Text("Check Result")
            }
            .navigationTitle("Check Result")
        }
        
    }
}

#Preview {
    CheckResultView()
}
