//
//  SummaryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "rectangle.grid.2x2.fill")
                    .font(.largeTitle)
                    .foregroundColor(.teal)
                Text("Summary")
            }
            .navigationTitle("Summary")
        }
    }
}

#Preview {
    SummaryView()
}
