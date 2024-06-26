//
//  PrizeNumberView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 21.05.2024.
//

import SwiftUI

struct PrizeNumberView: View {
    
    var number: String
    
    var body: some View {
        Text(number)
            .font(.system(.title, design: .monospaced, weight: .bold))
            .lineLimit(1)
            .foregroundStyle(.customWhite)
            .tracking(10)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 70)
            .background(Color.customBlue)
            .clipShape(.rect(cornerRadius: 10))
            .offset(x: 0, y: -10)
    }
}

#Preview {
    HStack {
        PrizeNumberView(number: "645777")
    }
}
