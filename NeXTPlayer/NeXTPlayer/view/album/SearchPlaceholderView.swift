//
//  SearchPlaceholderView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct SearchPlaceholderView: View {
    @Binding var searchTerm: String
     
    let suggestions = ["rammestein", "cry to me", "maneskin"]
    
    var body: some View {
        VStack {
            Text("Trending")
                .font(.title)
            ForEach(suggestions, id: \.self) { text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                }

            }
        }
    }
}

struct SearchPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlaceholderView(searchTerm: .constant("Scorpions"))
    }
}
