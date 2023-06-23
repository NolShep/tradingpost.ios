//
//  ContentView.swift
//  tradingpost.ios
//
//  Created by Nolan Shepherd on 6/16/23.
//

import SwiftUI

import SwiftUI

class TradeData: ObservableObject {
    @Published var trades: [TradeItem] = []
    
    func addTrade(_ trade: TradeItem) {
        trades.append(trade)
    }
}

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    @StateObject private var tradeData = TradeData()

    enum Tab {
        case home
        case newTrade
        case message
        case profile
    }
    /*
    let trades: [TradeItem] = [
        TradeItem(name: "Trade 1", type: "Buy", price: 100),
        TradeItem(name: "Trade 2", type: "Sell", price: 200),
        // Add more trades as needed
    ]
     */
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack {
                    List(tradeData.trades) { trade in
                        HStack(spacing: 16) {
                            if let image = trade.getImage() {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing, 8)
                            } else {
                                Color.clear
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing, 8)
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(trade.name)
                                    .font(.headline)
                                Text("\(trade.type) - Price: $\(trade.price)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .navigationTitle(tabTitle(for: selectedTab))
                    .navigationBarHidden(selectedTab == .newTrade)
                    .toolbar {
                        if selectedTab == .home {
                            Button("Edit") {
                                // future: edit button action
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(Tab.home)
            
            NavigationView {
                CreateTradeView(tradeData: tradeData)
            }
            .tabItem {
                Image(systemName: "plus.circle.fill")
                Text("New Trade")
            }
            .tag(Tab.newTrade)
            
            Text("Messages")
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Message")
                }
                .tag(Tab.message)
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(Tab.profile)
        }
    }
    
    private func tabTitle(for tab: Tab) -> String {
        switch tab {
        case .home:
            return "Open Trades"
        case .newTrade:
            return "New Trade"
        case .message:
            return "Messages"
        case .profile:
            return "Profile"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
