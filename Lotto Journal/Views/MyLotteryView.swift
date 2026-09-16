//
//  ContentView.swift
//  Lotto Journal
//
//  Created by Theppitak M. on 19.05.2024.
//

import SwiftUI
import SwiftData
import Alamofire
import SwiftyJSON

struct MyLotteryView: View {
    
    @State private var firstAPICall = CheckResultViewModel()
    
    @Query(sort: \DrawDate.date, order: .reverse) private var dates: [DrawDate]
    @Query private var lotteries: [Lottery]
    @Environment(\.modelContext) private var modelContext
    @State var isAdding: Bool = false
    @State var searchNumber: String = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if dates.isEmpty || lotteries.isEmpty {
                    ContentUnavailableView(
                        "No Lottery to Display",
                        systemImage: "plus.rectangle.on.rectangle",
                        description: Text("Tap \(Image(systemName: "plus.circle")) above to log your first one")
                    )
                } else {
                    List {
                        ForEach(dates) { date in
                            if date.lotteries.count > 0 {
                                Section {
                                    ForEach(date.lotteries) { lottery in
                                        HStack(alignment: .center) {
                                            HStack {
                                                Text(lottery.number)
                                                    .font(.system(.headline, design: .monospaced, weight: .semibold))
                                                    .tracking(7)
                                                let amountBought = lottery.amount
                                                if amountBought > 1 {
                                                    Text("x \(amountBought)")
                                                        .font(.system(.caption, weight: .thin))
                                                        .foregroundStyle(.secondary)
                                                }
                                            }
                                            Spacer()
                                            HStack(spacing: 5) {
                                                lottery.tagSymbol
                                                    .foregroundStyle(lottery.tagColor)
                                                    .imageScale(.small)
                                                Text(lottery.status.description)
                                                    .font(.system(.subheadline, weight: .light))
                                            }
                                        }
                                        .listRowInsets(.init(top: 10,
                                                             leading: 25,
                                                             bottom: 10,
                                                             trailing: 25))
                                    }
                                    .onDelete(perform: { indexSet in
                                        indexSet.forEach { index in
                                            let lottery = date.lotteries[index]
                                            modelContext.delete(lottery)
                                        }
                                    })
                                } header: {
                                    HStack(alignment: .bottom) {
                                        if let latestResultDate = firstAPICall.result.latestResultDate.toDate() {
                                            let upcomingDate = latestResultDate.upcomingDrawDate
                                            if date.date == upcomingDate {
                                                Text("Upcoming Draw")
                                            } else if date.date == latestResultDate {
                                                Text("Latest Draw")
                                            } else {
                                                Text(date.date.fullStringDate)
                                            }
                                        } else {
                                            Text(date.date.fullStringDate) // display fullStringDate while determine date from API
                                        }
                                        Spacer()
                                        let totalWon = date.totalWon.delimiter
                                        let totalInvestment = date.totalInvestment.delimiter
                                        HStack(alignment: .center, spacing: 5) {
                                            Image(systemName: "checkmark.seal.fill")
                                                .foregroundStyle(Color.customWhite)
                                            Text(totalWon)
                                            Text("•")
                                                .foregroundStyle(Color.customWhite.opacity(0.6))
                                            Image(systemName: "basket.fill")
                                                .foregroundStyle(Color.customWhite)
                                            Text(totalInvestment)
                                        }
                                        .font(.system(.caption, design: .default, weight: .medium))
                                        .foregroundStyle(Color.customWhite)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background {
                                            Capsule(style: .continuous)
                                                .fill(
                                                    LinearGradient(
                                                        colors: [Color.customBlue.opacity(0.92), Color.customBlue],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    )
                                                )
                                        }
                                        .overlay {
                                            Capsule(style: .continuous)
                                                .strokeBorder(
                                                    LinearGradient(
                                                        colors: [Color.white.opacity(0.45), Color.white.opacity(0.12)],
                                                        startPoint: .topLeading,
                                                        endPoint: .bottomTrailing
                                                    ),
                                                    lineWidth: 1
                                                )
                                        }
                                        .shadow(color: Color.customBlue.opacity(0.25), radius: 4, x: 0, y: 2)
                                    }
                                }
                                .headerProminence(.increased)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Lotter\(lotteries.count > 1 ? "ies" : "y")")
            .toolbar {
                if !lotteries.isEmpty {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAdding.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            }
            .sheet(isPresented: $isAdding) {
                AddMyLotteryView()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
            .refreshable {
                processDatesAndLotteries()
            }
        }
        .onAppear {
            firstAPICall.latestResultAPI()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                processDatesAndLotteries()
            }
        }
        .onChange(of: lotteries) { _, _ in
            processDatesAndLotteries()
        }
    }
    
    func updateResultAPI(param: Parameters, completion: @escaping ([JSON]) -> Void) {
        AF.request(
            "https://www.glo.or.th/api/checking/getcheckLotteryResult",
            method: .post,
            parameters: param,
            encoding: JSONEncoding.prettyPrinted,
            headers: nil)
        .validate(statusCode: 200 ..< 299)
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let json = try JSON(data: data)
                    let pathResult: [JSONSubscriptType] = ["response", "result"]
                    let result = json[pathResult].array ?? []
                    completion(result)
                } catch {
                    print("Error parsing JSON: \(error)")
                    completion([])
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                completion([])
            }
        }
    }
    
    func updateLotteryStatus(for lottery: Lottery, with prizeAmount: String, on date: Date, latestResultDate: Date?) {
        if prizeAmount == "-" && date == latestResultDate?.upcomingDrawDate {
            lottery.status = .isWaiting
        } else if prizeAmount == Prize.first.stringPrize {
            lottery.status = .doesWon
            lottery.amountWon = Prize.first.intPrize
        } else if prizeAmount == Prize.firstNB.stringPrize {
            lottery.status = .doesWon
            lottery.amountWon = Prize.firstNB.intPrize
        } else if prizeAmount == Prize.second.stringPrize {
            lottery.status = .doesWon
            lottery.amountWon = Prize.second.intPrize
        } else if prizeAmount == Prize.third.stringPrize {
            lottery.status = .doesWon
            lottery.amountWon = Prize.third.intPrize
        } else if prizeAmount == Prize.fourth.stringPrize {
            lottery.status = .doesWon
            lottery.amountWon = Prize.fourth.intPrize
        } else if prizeAmount == Prize.fifth.stringPrize {
            lottery.status = .doesWon
            lottery.amountWon = Prize.fifth.intPrize
        } else if prizeAmount == Prize.threePre.stringPrize {
            lottery.status = .doesWon
            lottery.amountWon = Prize.threePre.intPrize
        } else if prizeAmount == Prize.threeSuf.stringPrize {
            lottery.status = .doesWon
            lottery.amountWon = Prize.threeSuf.intPrize
        } else if prizeAmount == Prize.twoSuf.stringPrize {
            lottery.status = .doesWon
            lottery.amountWon = Prize.twoSuf.intPrize
        } else {
            lottery.status = .doesNotWon
        }
    }
    
    func processDatesAndLotteries() {
        dates.forEach { date in
            updateResultAPI(param: date.params) { result in
                date.result = result
                let latestResultDate = firstAPICall.result.latestResultDate.toDate()
                lotteries.forEach { lottery in
                    for prize in date.lotteryPrizeResult {
                        if let prizeAmount = prize[lottery.number] {
                            updateLotteryStatus(for: lottery, with: prizeAmount, on: date.date, latestResultDate: latestResultDate)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MyLotteryView()
        .modelContainer(for: DrawDate.self, inMemory: true)
}
