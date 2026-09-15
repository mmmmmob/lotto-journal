//
//  PrizeNumberMultipleView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 21.05.2024.
//

import SwiftUI

struct PrizeNumberMultipleView: View {
    
    let number: [String]
    
    private var pages: [[String]] {
        let sortedNumber = number.sorted()
        guard !sortedNumber.isEmpty else { return [] }
        let chunkSize = 10
        return stride(from: 0, to: sortedNumber.count, by: chunkSize).map {
            Array(sortedNumber[$0..<min($0 + chunkSize, sortedNumber.count)])
        }
    }
    
    var body: some View {
        Group {
            if pages.count > 1 {
                TabView {
                    ForEach(pages.indices, id: \.self) { pageIndex in
                        VStack {
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 8) {
                                ForEach(pages[pageIndex].indices, id: \.self) { itemIndex in
                                    Text(pages[pageIndex][itemIndex])
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.top, 20)
                            Spacer(minLength: 0)
                        }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .tint(Color.customWhite)
                .frame(height: 250)
            } else {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 8) {
                    let sortedNumber = number.sorted()
                    ForEach(sortedNumber.indices, id: \.self) { index in
                        Text(sortedNumber[index])
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
            }
        }
        .font(.system(.title2, design: .monospaced, weight: .bold))
        .tracking(8)
        .foregroundStyle(Color.customWhite)
        .multilineTextAlignment(.center)
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
    PrizeNumberMultipleView(number: ["483927", "194820", "583726", "492837", "918273", "192837", "928374", "198273", "837462", "564738","293847", "182736", "918374", "637281", "271635", "482736", "564829", "192837", "182736", "918273","281736", "462837", "364728", "728193", "837261", "293847", "192736", "182736", "837462", "192837","918273", "637281", "293847", "284736", "918273", "182736", "637281", "837462", "293847", "182736","918273", "293847", "182736", "928374", "192837","837462", "193847", "192837", "293847", "182736"])
        .padding()
}
