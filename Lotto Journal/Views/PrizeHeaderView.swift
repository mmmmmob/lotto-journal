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
                .font(.system(.title2, design: .default, weight: .bold))
            Spacer()
            Text("฿\(amount)")
                .font(.system(.callout, design: .default, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .offset(x: 0, y: 5)
    }
}

#Preview {
    PrizeHeaderView(prize: "First Prize", amount: "6,000,000")
}
