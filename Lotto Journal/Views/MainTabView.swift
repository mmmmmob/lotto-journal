//
//  MainTabView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
            MyLotteryView()
                .tabItem {
                    Image(systemName: "123.rectangle")
                    Text("My Lottery")
                }
                .tag(1)
            SummaryView()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Summary")
                }
                .tag(2)
            CheckResultView()
                .tabItem {
                    Image(systemName: "1.magnifyingglass")
                    Text("Check Result")
                }
                .tag(3)
        })
        .tint(.teal)
    }
}

#Preview {
    MainTabView()
}
