//
//  ContentView.swift
//  tradingpost.ios
//
//  Created by Nolan Shepherd on 6/16/23.
//

import SwiftUI

struct ContentView: View {
    let trades: [TradeItem] = [
        TradeItem(name: "Trade 1", type: "Buy", price: 100),
        TradeItem(name: "Trade 2", type: "Sell", price: 200),
        // Add more trades as needed
    ]

    var body: some View {
        NavigationView {
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
            .navigationTitle("Open Trades")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

