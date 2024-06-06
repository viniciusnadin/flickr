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
    private let imageSize = UIScreen.main.bounds.width / 2 - 10
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)

    var body: some View {
        NavigationView {
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
                            LazyVGrid(columns: columns) {
                                ForEach(viewModel.images) { image in
                                    NavigationLink(destination: ImageDetailView(viewModel: ImageDetailViewModel(image: image))) {
                                        KFImage(URL(string: image.media.m))
                                            .resizable()
                                            .placeholder {
                                                ProgressView()
                                            }
                                            .cancelOnDisappear(true)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: imageSize, height: imageSize)
                                            .clipped()
                                            .cornerRadius(10)
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                }
            }
            .navigationBarTitle(viewModel.viewTitle)
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel(repository: SearchRepository()))
}

