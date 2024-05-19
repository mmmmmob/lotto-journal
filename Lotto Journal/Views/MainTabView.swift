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
            YourLotteryView()
                .tabItem {
                    Image(systemName: "123.rectangle")
                    Text("Your Lottery")
                }
                .tag(1)
            Text("Tab Content 2")
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Summary")
                }
                .tag(2)
            Text("Tab Content 3")
                .tabItem {
                    Image(systemName: "1.magnifyingglass")
                    Text("Check Result")
                }
                .tag(3)
        })
        .tint(Color.teal)
    }
}

#Preview {
    MainTabView()
}
