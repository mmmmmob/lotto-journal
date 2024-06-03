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
            ContentUnavailableView(
                "Summary Unavailable",
                systemImage: "chart.bar.xaxis",
                description: Text("Keep using to track your progress")
            )
                .navigationTitle("Summary")
        }
    }
}

#Preview {
    SummaryView()
}
