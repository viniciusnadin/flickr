//
//  ImageSearchView.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import SwiftUI
import Kingfisher

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel
    private let imageSize = UIScreen.main.bounds.width / 3 - 1
    private let columnGrid = Array(repeating: GridItem(.flexible(), spacing: 1), count: 3)

    var body: some View {
        NavigationStack {
            VStack {
                SearchBar(text: $viewModel.searchText)
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else {
                    if viewModel.images.count < 1 {
                        Spacer()
                        Text("Type something in the search bar.")
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columnGrid, spacing: 1) {
                                ForEach(viewModel.images) { image in
                                    NavigationLink(value: image) {
                                        KFImage(URL(string: image.media.m))
                                            .resizable()
                                            .placeholder {
                                                ProgressView()
                                            }
                                            .cancelOnDisappear(true)
                                            .scaledToFill()
                                            .frame(width: imageSize, height: imageSize)
                                            .clipped()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationDestination(for: ImageObject.self) { image in
                ImageDetailView(viewModel: ImageDetailViewModel(image: image))
            }
        }
    }
}

