//
//  ResultView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 22.05.2024.
//

import SwiftUI

struct ResultView: View {
    
    @StateObject var viewModel = CheckResultViewModel()
    @Environment(\.isSearching) private var isSearching: Bool
    @Binding var text: String
    @Binding var date: Date
    
    var body: some View {
        if isSearching {
            Text("\(viewModel.result.userResult)")
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .onChange(of: text) {
                    if text.count == 6 {
                        viewModel.NumberSearchAPI(searchNum: text, date: date.periodDate)
                    }
                }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    @State var text = "..."
    @State var date = Date()
    return ResultView(text: $text, date: $date)
}
