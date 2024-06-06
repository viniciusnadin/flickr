//
//  ImageSearchViewModel.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation
import Combine

public class SearchViewModel: ObservableObject {

    private var cancellable: AnyCancellable?
    private var searchCancellable: AnyCancellable?
    private let repository: SearchRepositoryProtocol

    @Published public var images: [ImageObject] = []
    @Published public var isLoading = false
    @Published public var searchText = "" {
        didSet {
            debounceSearchText()
        }
    }

    public var viewTitle: String {
        "Flickr Image Search"
    }

    public init(repository: SearchRepositoryProtocol) {
        self.repository = repository
        debounceSearchText()
    }

    private func debounceSearchText() {
        searchCancellable = $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] text in
                self?.searchImages(with: text)
            })
    }

    public func searchImages(with tags: String) {
        guard !tags.isEmpty else {
            DispatchQueue.main.async {
                self.images = []
            }
            return
        }
        isLoading = true

        Task {
            do {
                let fetchedImages = try await repository.searchImage(tags)
                DispatchQueue.main.async {
                    self.images = fetchedImages
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print(error.localizedDescription)
                }
            }
        }
    }
}
