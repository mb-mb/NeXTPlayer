//
//  MovieSearchView.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 03/10/23.
//

import SwiftUI

struct MovieSearchView: View {
    @StateObject var viewModel = MovieListViewModel()
    var body: some View {
        NavigationView {
            Group {
                Spacer()
                if viewModel.searchTerm.isEmpty {
                    // MoviePlaceholderView(searchTerm: $viewModel.searchTerm)
                    EmptyView()
                } else {
                    MovieListView(viewModel: viewModel)
                }
                Spacer()
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Movies")
        }
    }
        
}

struct MoviePlaceholderView: View {
    @Binding var searchTerm: String
     
    let suggestions = ["They Live", "Lord of the Rings", "TWD"]
    
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

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
