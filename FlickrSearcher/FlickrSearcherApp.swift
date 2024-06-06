//
//  FlickrSearcherApp.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import SwiftUI

@main
struct FlickrSearcherApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = SearchRepository()
            let viewModel = SearchViewModel(repository: repository)
            SearchView(viewModel: viewModel)
        }
    }
}
