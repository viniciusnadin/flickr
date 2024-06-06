//
//  ImageDetailView.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {

    private let viewModel: ImageDetailViewModel

    init(viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel
    }

    private let imageSize = UIScreen.main.bounds.width - 10

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                KFImage(URL(string: viewModel.imagePath))
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .cancelOnDisappear(true)
                    .background(.blue)
                    .scaledToFit()
                    .background(.blue)
                    .frame(maxWidth: imageSize, maxHeight: imageSize * 2)
                    .background(.blue)


                Text(viewModel.imageTitle)
                    .font(.headline)

                Text(viewModel.imageDescription)
                    .font(.body)

                Text(viewModel.imageAuthor)
                    .font(.subheadline)

                Text(viewModel.imagePublicationDate)
                    .font(.subheadline)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    SearchView(viewModel: SearchViewModel(repository: SearchRepository()))
//}

