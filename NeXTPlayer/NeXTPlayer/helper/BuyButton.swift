//
//  BuyButton.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct BuyButton: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let url = URL(string: urlString), let price = price {
            Link(destination: url) {
                Text("\(String(format: "%0.2f", price)) \(currency)")
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
}


struct BuyButton_Previews: PreviewProvider {
    static var previews: some View {
        BuyButton(urlString: Song.mockData().first!.previewURL,
                  price: 1.0,
                  currency: "USD")
    }
}
