//
//  MainTabView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab: Int = 1
    @State var date: Date = Date()
    @State var number: String = ""
    @State private var viewModel = CheckResultViewModel()
    
    @Environment(QAService.self) private var qaService
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("My Lottery", systemImage: "123.rectangle", value: 1) {
                MyLotteryView()
            }
            Tab("Summary", systemImage: "list.bullet.clipboard", value: 2) {
                SummaryView()
            }
            Tab("Prize Result", systemImage: "binoculars", value: 3) {
                CheckResultView(date: $date)
            }
            Tab("", systemImage: "1.magnifyingglass", value: 4, role: .search) {
                NavigationStack {
                    ResultView(text: $number, date: date)
                }
                .searchable(text: $number, prompt: "Check Your Lottery")
                .keyboardType(.numberPad)
            }
        }
        .tabViewSearchActivation(.searchTabSelection)
        .tint(.blue)
        .task {
            await viewModel.latestResult()
            if let latestDate = viewModel.result.latestResultDate.toDate() {
                date = latestDate
            }
        }
        .onChange(of: scenePhase) { _, newPhase in
            switch newPhase {
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
        case .searchResult:
            selectedTab = 4
        }
        
        qaService.action = nil
    }
}

#Preview {
    MainTabView()
        .environment(QAService.shared)
        .modelContainer(for: DrawDate.self, inMemory: true)
}
