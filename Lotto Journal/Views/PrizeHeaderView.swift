//
//  PrizeHeaderView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 21.05.2024.
//

import SwiftUI

struct PrizeHeaderView: View {
    
    var prize: String
    var amount: String
    
    var body: some View {
        HStack {
            Text(prize)
                .font(.system(.headline, design: .default, weight: .semibold))
            Spacer()
            Text("฿\(amount)")
                .font(.system(.subheadline, design: .default, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 4)
        .padding(.top, 4)
    }
}

#Preview {
    PrizeHeaderView(prize: "First Prize", amount: "6,000,000")
}
