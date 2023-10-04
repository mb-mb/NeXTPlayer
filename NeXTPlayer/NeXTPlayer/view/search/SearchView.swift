//
//  SearchView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 04/10/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchItem: String = ""
    @State private var selectEntityType = EntityType.all
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Select the media", selection: $selectEntityType) {
                    ForEach(EntityType.allCases) { type in
                        Text(type.name())
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                Divider()
                Spacer()
            }
            .searchable(text: $searchItem)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
