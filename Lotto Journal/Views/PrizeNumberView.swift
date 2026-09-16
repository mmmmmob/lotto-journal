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
            .foregroundStyle(Color.customWhite)
            .tracking(8)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(height: 64)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [Color.customBlue.opacity(0.92), Color.customBlue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .overlay {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            colors: [Color.white.opacity(0.45), Color.white.opacity(0.12)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
            .shadow(color: Color.customBlue.opacity(0.25), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    HStack {
        PrizeNumberView(number: "645777")
    }
    .padding()
}
