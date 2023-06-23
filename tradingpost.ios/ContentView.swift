//
//  ContentView.swift
//  tradingpost.ios
//
//  Created by Nolan Shepherd on 6/16/23.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home
        case newTrade
        case dummy1
        case dummy2
    }
    
    let trades: [TradeItem] = [
        TradeItem(name: "Trade 1", type: "Buy", price: 100),
        TradeItem(name: "Trade 2", type: "Sell", price: 200),
        // Add more trades as needed
    ]
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                VStack {
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
                CreateTradeView()
            }
            .tabItem {
                Image(systemName: "plus.circle.fill")
                Text("New Trade")
            }
            .tag(Tab.newTrade)
            
            Text("Dummy 1")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Dummy 1")
                }
                .tag(Tab.dummy1)
            
            Text("Dummy 2")
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Dummy 2")
                }
                .tag(Tab.dummy2)
        }
    }
    
    private func tabTitle(for tab: Tab) -> String {
        switch tab {
        case .home:
            return "Open Trades"
        case .newTrade:
            return "New Trade"
        case .dummy1:
            return "Dummy 1"
        case .dummy2:
            return "Dummy 2"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
