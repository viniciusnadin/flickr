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
    private let imageSize = UIScreen.main.bounds.width
    @State private var attributedDescription: AttributedString = AttributedString("")

    init(viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(viewModel.imageTitle)
                    .font(.headline)
                KFImage(URL(string: viewModel.imagePath))
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .cancelOnDisappear(true)
                    .scaledToFit()
                    .frame(maxWidth: imageSize, maxHeight: imageSize * 2)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(attributedDescription)
                        .font(.body)
                        .onAppear {
                            viewModel.imageDescription.convertHTMLToAttributedString { attributedString in
                                self.attributedDescription = attributedString
                            }
                        }
                    
                    Text(viewModel.imagePublicationDate)
                        .font(.subheadline)
                }
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ImageDetailView(viewModel: ImageDetailViewModel(image: ImageObject(title: "Porcupine", link: "https://live.staticflickr.com/65535/53769361124_4f4e902d92_m.jpg", media: ImageObject.Media(m: "https://live.staticflickr.com/65535/53769361124_4f4e902d92_m.jpg"), description: "Porcupine in A Tree", published: "2024-06-04T15:32:23Z", author: "nobody@flickr.com (\"ZoomZoom Du Buisson\")")))
}

