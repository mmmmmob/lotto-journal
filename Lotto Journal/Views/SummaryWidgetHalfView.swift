//
//  SummaryWidgetHalfView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 05.06.2024.
//

import SwiftUI

struct SummaryWidgetHalfView: View {
    
    var numberToShow: Int
    var headerText: String
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            Text(headerText)
                .font(.subheadline)
                .foregroundStyle(Color.customWhite.opacity(0.85))
            Text("฿\(numberToShow.delimiter)")
                .font(.system(.title2, design: .rounded, weight: .bold))
                .foregroundStyle(Color.customWhite)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.customBlue.opacity(0.92), Color.customBlue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [Color.white.opacity(0.45), Color.white.opacity(0.12)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        }
        .shadow(color: Color.customBlue.opacity(0.25), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    SummaryWidgetHalfView(numberToShow: 30000, headerText: "💸 Total Spending")
}
