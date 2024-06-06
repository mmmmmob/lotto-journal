//
//  PrizeNumberMultipleView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 21.05.2024.
//

import SwiftUI

struct PrizeNumberMultipleView: View {
    
    var number: [String]
    
    var body: some View {
        ScrollView() {
            LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], alignment: .center, spacing: 8) {
                let sortedNumber = number.sorted()
                ForEach(sortedNumber.indices, id: \.self) { index in
                    Text(sortedNumber[index])
                }
            }
        }
        .font(.system(.title2, design: .monospaced, weight: .bold))
        .padding(.init(top: 20, leading: 10, bottom: 20, trailing: 10))
        .frame(maxHeight: {number.count > 10 ? 300 : .infinity}())
        .tracking(10)
        .foregroundStyle(.customWhite)
        .multilineTextAlignment(.center)
        .background(Color.customBlue)
        .clipShape(.rect(cornerRadius: 10))
        .offset(x: 0, y: -10)
    }
}

#Preview {
    PrizeNumberMultipleView(number: ["483927", "194820", "583726", "492837", "918273", "192837", "928374", "198273", "837462", "564738","293847", "182736", "918374", "637281", "271635", "482736", "564829", "192837", "182736", "918273","281736", "462837", "364728", "728193", "837261", "293847", "192736", "182736", "837462", "192837","918273", "637281", "293847", "284736", "918273", "182736", "637281", "837462", "293847", "182736","918273", "293847", "182736", "928374", "192837","837462", "193847", "192837", "293847", "182736"])
}
