//
//  SearchResultsViewModel.swift
//  NeXTPlayer
//
//  Created by marcelo bianchi on 12/10/21.
//

import Combine
import Foundation

class SearchResultsViewModel: ObservableObject {
    
    let items: [Artist]
    
    init(items: [Artist]) {
        self.items = items
    }
    
}
