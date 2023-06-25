//
//  TradeItem.swift
//  tradingpost.ios
//
//  Created by Nolan Shepherd on 6/18/23.
//

import Foundation
import SwiftUI

class TradeItem: Identifiable {
    //trade obj
    let id = UUID()
    var name: String
    var type: String
    var price: Double
    var imageData: Data?

    init(name: String, type: String, price: Double, imageData: Data? = nil) {
        self.name = name
        self.type = type
        self.price = price
        self.imageData = imageData
    }

    //get trade img
    func getImage() -> Image? {
        guard let imageData = imageData else {
            return nil
        }
        
        if let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        else {
            return nil
        }
    }
}

