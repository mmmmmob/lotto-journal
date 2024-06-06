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
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.customBlue)
            .frame(maxWidth: .infinity, maxHeight: 150)
            .overlay {
                VStack(alignment: .trailing) {
                    Text(headerText)
                        .font(.system(.caption, design: .default, weight: .regular))
                        .foregroundStyle(.customWhite)
                    Text("฿\(numberToShow.delimiter)")
                        .font(.system(.largeTitle, design: .rounded, weight: .bold))
                        .foregroundStyle(.customWhite)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
            }
    }
}

#Preview {
    SummaryWidgetHalfView(numberToShow: 30000, headerText: "💸 Total Spending")
}
