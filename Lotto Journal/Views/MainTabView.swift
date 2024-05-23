//
//  MainTabView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab: Int = 1
    
    @EnvironmentObject var qaService: QAService
    @Environment(\.scenePhase) var scenePhase
    
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
                    Text("Prize Result")
                }
                .tag(3)
        })
        .tint(.teal)
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .active:
                performAction()
            default:
                break
            }
        }
    }
    
    func performAction() {
        guard let action = qaService.action else { return }
        
        // read action from user tap on Quick Action (QA enum) and change $selectedTab based on those action
        switch action {
        case .myLottery:
            selectedTab = 1
        case .summary:
            selectedTab = 2
        case .result:
            selectedTab = 3
        }
        
        qaService.action = nil
    }
}

#Preview {
    MainTabView()
}
