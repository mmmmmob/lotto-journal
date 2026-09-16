//
//  CheckLotteryView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 20.05.2024.
//

import SwiftUI

struct CheckResultView: View {
    
    @State private var viewModel = CheckResultViewModel()
    @Binding var date: Date
    
    init(date: Binding<Date> = .constant(Date())) {
        self._date = date
    }
    
    private var maxDrawDate: Date {
        viewModel.result.latestResultDate.toDate() ?? Date()
    }
    
    private var canGoPrevious: Bool {
        date > viewModel.firstDayOfResult
    }
    
    private var canGoNext: Bool {
        date < maxDrawDate
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 20) {
                            Color.clear
                                .frame(height: 0)
                                .id("top")
                            
                            // Compact DatePicker, Steppers & Latest Draw inside a Liquid Glass card
                            HStack(spacing: 8) {
                                // Previous Draw Stepper Button
                                Button {
                                    date = date.previousDrawDate
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .font(.subheadline.weight(.semibold))
                                        .frame(width: 32, height: 32)
                                        .background(.ultraThinMaterial, in: Circle())
                                }
                                .buttonStyle(.plain)
                                .disabled(!canGoPrevious)
                                .opacity(canGoPrevious ? 1.0 : 0.3)
                                
                                DatePicker(
                                    "Draw Date",
                                    selection: $date,
                                    in: viewModel.firstDayOfResult...maxDrawDate,
                                    displayedComponents: .date
                                )
                                .datePickerStyle(.compact)
                                .labelsHidden()
                                
                                // Next Draw Stepper Button
                                Button {
                                    let nextDate = date.upcomingDrawDate
                                    date = nextDate > maxDrawDate ? maxDrawDate : nextDate
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .font(.subheadline.weight(.semibold))
                                        .frame(width: 32, height: 32)
                                        .background(.ultraThinMaterial, in: Circle())
                                }
                                .buttonStyle(.plain)
                                .disabled(!canGoNext)
                                .opacity(canGoNext ? 1.0 : 0.3)
                                
                                Spacer()
                                
                                Button {
                                    viewModel.latestResultAPI()
                                    if let latestResultDate = viewModel.result.latestResultDate.toDate() {
                                        date = latestResultDate
                                    }
                                } label: {
                                    Label("Latest", systemImage: "calendar.badge.clock")
                                        .font(.subheadline.weight(.semibold))
                                }
                                .buttonStyle(.borderedProminent)
                                .buttonBorderShape(.capsule)
                                .tint(Color.customBlue)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .overlay {
                                RoundedRectangle(cornerRadius: 18, style: .continuous)
                                    .strokeBorder(
                                        LinearGradient(
                                            colors: [Color.white.opacity(0.45), Color.primary.opacity(0.08)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            }
                            .shadow(color: Color.black.opacity(0.04), radius: 8, x: 0, y: 3)
                            .padding(.top, 4)
                            
                            if viewModel.result.fetchLatestStatus == 500 {
                                VStack {
                                    Spacer()
                                    ProgressView("Loading...")
                                    Spacer()
                                }
                                .frame(minHeight: max(geometry.size.height - 180, 200))
                            } else if viewModel.result.fetchLatestStatus == 200 && viewModel.result.firstPrize != "-" {
                                VStack(spacing: 20) {
                                    // First Prize
                                    VStack(alignment: .leading, spacing: 6) {
                                        PrizeHeaderView(prize: String(localized: "First Prize"), amount: "6,000,000")
                                        PrizeNumberView(number: viewModel.result.firstPrize)
                                    }
                                    
                                    // Three Digits Prefix
                                    VStack(alignment: .leading, spacing: 6) {
                                        PrizeHeaderView(prize: String(localized: "Three Digits Prefix"), amount: "4,000")
                                        HStack(spacing: 12) {
                                            ForEach(viewModel.result.threeDigitsPrefix.indices, id: \.self) { index in
                                                PrizeNumberView(number: viewModel.result.threeDigitsPrefix[index])
                                            }
                                        }
                                    }
                                    
                                    // Three Digits Suffix
                                    VStack(alignment: .leading, spacing: 6) {
                                        PrizeHeaderView(prize: String(localized: "Three Digits Suffix"), amount: "4,000")
                                        HStack(spacing: 12) {
                                            ForEach(viewModel.result.threeDigitsSuffix.indices, id: \.self) { index in
                                                PrizeNumberView(number: viewModel.result.threeDigitsSuffix[index])
                                            }
                                        }
                                    }
                                    
                                    // Two Digits Suffix
                                    VStack(alignment: .leading, spacing: 6) {
                                        PrizeHeaderView(prize: String(localized: "Two Digits Suffix"), amount: "2,000")
                                        PrizeNumberView(number: viewModel.result.twoDigitsSuffix)
                                    }
                                    
                                    // First Prize Neighbors
                                    VStack(alignment: .leading, spacing: 6) {
                                        PrizeHeaderView(prize: String(localized: "First Prize Neighbors"), amount: "100,000")
                                        HStack(spacing: 12) {
                                            ForEach(viewModel.result.firstPrizeNeighbors.indices, id: \.self) { index in
                                                PrizeNumberView(number: viewModel.result.firstPrizeNeighbors[index])
                                            }
                                        }
                                    }
                                    
                                    // Second Prize
                                    VStack(alignment: .leading, spacing: 6) {
                                        PrizeHeaderView(prize: String(localized: "Second Prize"), amount: "200,000")
                                        PrizeNumberMultipleView(number: viewModel.result.secondPrize)
                                    }
                                    
                                    // Third Prize
                                    VStack(alignment: .leading, spacing: 6) {
                                        PrizeHeaderView(prize: String(localized: "Third Prize"), amount: "80,000")
                                        PrizeNumberMultipleView(number: viewModel.result.thirdPrize)
                                    }
                                    
                                    // Fourth Prize
                                    VStack(alignment: .leading, spacing: 6) {
                                        PrizeHeaderView(prize: String(localized: "Fourth Prize"), amount: "40,000")
                                        PrizeNumberMultipleView(number: viewModel.result.fourthPrize)
                                    }
                                    
                                    // Fifth Prize
                                    VStack(alignment: .leading, spacing: 6) {
                                        PrizeHeaderView(prize: String(localized: "Fifth Prize"), amount: "20,000")
                                        PrizeNumberMultipleView(number: viewModel.result.fifthPrize)
                                    }
                                }
                            } else {
                                VStack {
                                    Spacer()
                                    ContentUnavailableView(
                                        "No Result Available",
                                        systemImage: "calendar.badge.exclamationmark",
                                        description: Text("Please select another date")
                                    )
                                    Spacer()
                                }
                                .frame(minHeight: max(geometry.size.height - 180, 200))
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 60)
                    }
                    .scrollBounceBehavior(.basedOnSize)
                    .scrollIndicators(.hidden)
                    .onChange(of: date) { _, newDate in
                        withAnimation {
                            proxy.scrollTo("top", anchor: .top)
                        }
                        viewModel.drawDateResultAPI(newDate.params)
                    }
                }
            }
            .navigationTitle("Prize Result")
        }
        .onAppear {
            viewModel.latestResultAPI()
        }
        .onChange(of: viewModel.result.latestResultDate) { _, newLatestDate in
            if let latestResultDate = newLatestDate.toDate() {
                date = latestResultDate
            }
        }
    }
}

#Preview {
    @Previewable @State var date = Date()
    CheckResultView(date: $date)
}
