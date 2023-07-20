//
//  ContentView.swift
//  tradingpost.ios
//
//  Created by Nolan Shepherd on 6/16/23.
//

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
    @StateObject private var profileData = ProfileData()

    enum Tab {
        case home
        case newTrade
        case message
        case profile
    }
    
    // Testing purpose trades
    let trades: [TradeItem] = [
        TradeItem(name: "Trade 1", type: "Buy", price: 100),
        TradeItem(name: "Trade 2", type: "Sell", price: 200),
        TradeItem(name: "Trade 3", type: "Exchange", price: 150),
    ]
     
    var body: some View {
        TabView(selection: $selectedTab) {
            ZStack {
                Color.black.ignoresSafeArea()
                NavigationView {
                    List(trades) { trade in
                        TradeRow(trade: trade)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle(tabTitle(for: selectedTab))
                    .navigationBarHidden(selectedTab == .newTrade)
                    .toolbar {
                        if selectedTab == .home {
                            Button("Edit") {
                                // future: edit button action
                            }
                        }
                    }
                    .background(Color.clear)
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
            
            NavigationView {
                ProfileView(profileData: profileData)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(Tab.profile)
        }
        .accentColor(.orange)
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

// Encapsulated Trade Row View
struct TradeRow: View {
    var trade: TradeItem
    
    var body: some View {
        HStack(spacing: -10) {
            if let data = trade.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(8)
                    .padding(12)
            } else {
                Image(systemName: "photo") // placeholder image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(8)
                    .padding(12)
                
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(trade.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text("\(trade.type) - Price: $\(String(format: "%.2f", trade.price))")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding(.leading, 10)
            Spacer()
        }
        .padding(.vertical, 14)
        .background(Color.orange.opacity(0.4))
        .cornerRadius(8)
        .padding(.horizontal, 4)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
