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
     
    
    //home trades struct
    var body: some View {
            TabView(selection: $selectedTab) {
                NavigationView {
                    VStack {
                        // Display the 3 demo trades here
                        List(trades) { trade in
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
                                    Text("\(trade.type) - Price: $\(String(format: "%.2f", trade.price))")
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
                    
                        .padding(.horizontal, 12) // Add horizontal padding to the content
                                            .background(
                                                Color.blue
                                                    .ignoresSafeArea()
                                            )
                        Spacer()
                        
                    }
                   
        

            }
            
            //home
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            .tag(Tab.home)
            
            //new trade
            NavigationView {
                CreateTradeView(tradeData: tradeData)
            }
            .tabItem {
                Image(systemName: "plus.circle.fill")
                Text("New Trade")
            }
            .tag(Tab.newTrade)
            
            //dummy message page
            Text("Messages")
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Message")
                }
                .tag(Tab.message)
            
            //profile
            NavigationView {
                ProfileView(profileData: profileData)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
            .tag(Tab.profile)

        }
    }
    
    //menu bar
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
