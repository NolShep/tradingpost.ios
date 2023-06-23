//
//  NewTrade.swift
//  tradingpost.ios
//
//  Created by Nolan Shepherd on 6/19/23.
//

import Foundation
import SwiftUI

struct CreateTradeView: View {
    @State private var tradeName: String = ""
    @State private var tradeType: String = ""
    @State private var tradePrice: String = ""
    
    @ObservedObject var tradeData: TradeData

    var body: some View {
        VStack {
            TextField("Trade Name", text: $tradeName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Trade Type", text: $tradeType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Trade Price", text: $tradePrice)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()

            Button(action: {
                // trade creation
                createTrade()
            }) {
                Text("Create Trade")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Create Trade")
    }
    
    private func createTrade() {
            guard let price = Double(tradePrice) else {
                return
            }
            
            let trade = TradeItem(name: tradeName, type: tradeType, price: price)
            tradeData.addTrade(trade)
            
            tradeName = ""
            tradeType = ""
            tradePrice = ""
        }
    }

struct CreateTradeView_Previews: PreviewProvider {
    static var previews: some View {
        // mock TradeData object
        let tradeData = TradeData() 
        CreateTradeView(tradeData: tradeData)
    }
}

