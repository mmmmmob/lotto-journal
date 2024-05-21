//
//  CheckLotteryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import SwiftUI

struct CheckResultView: View {
    
    @StateObject var viewModel = CheckResultViewModel()
    @State var text: String = ""
    @State var date = Date()

    var body: some View {
        NavigationStack {
            DatePicker("🗓️ Draw Date", selection: $date
                       , displayedComponents: .date)
                .padding()
                Spacer()
                .navigationTitle("Check Result")
        }
        .searchable(text: $text)
        .onChange(of: date) {
            viewModel.APICall(date.params)
        }
    }
    
}

#Preview {
    CheckResultView()
}
