//
//  BuyButton.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct BuySongButton: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let price = price {
            BuyButton(urlString: urlString,
                      price: price,
                      currency: currency)
        } else {
            Text("Album Only")
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}

struct BuyButton: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let url = URL(string: urlString), let priceString = formattedPrice() {
            Link(destination: url) {
                Text("\(priceString)")
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
    func formattedPrice() -> String? {
        guard let price = price else { return nil }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        
        let priceString = formatter.string(from: NSNumber(value: price))
        return priceString
    
    }
}


struct BuyButton_Previews: PreviewProvider {
    static var previews: some View {
        BuyButton(urlString: Song.example().previewURL,
                  price: Song.example().collectionPrice,
                  currency: Song.example().currency)
    }
}
