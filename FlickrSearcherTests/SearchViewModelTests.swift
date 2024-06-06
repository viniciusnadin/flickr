//
//  SearchViewModelTests.swift
//  FlickrSearcherTests
//
//  Created by Vinicius Nadin on 06/06/24.
//

import XCTest
import Combine
import FlickrSearcher

final class SearchViewModelTests: XCTestCase {

    func test_searchViewModel_initialState_isCorrect() {
        let (viewModel, _, _) = makeSUT()

        XCTAssertTrue(viewModel.images.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertEqual(viewModel.viewTitle, "Flickr Image Search")
    }

    func test_searchTextDebounce_delaysSearchRequestFor300Milliseconds() {
        var (viewModel, _, cancellables) = makeSUT()
        let expectation = XCTestExpectation(description: "Debounce search text")

        viewModel.$searchText
            .dropFirst()
            .sink { text in
                XCTAssertEqual(text, "test")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchText = "test"

        wait(for: [expectation], timeout: 1.0)
    }

    func test_searchImages_withTag_returnsExpectedImages() async {
        var (viewModel, repository, cancellables) = makeSUT()
        let expectation = XCTestExpectation(description: "Search images success")
        let mockImages = [
            ImageObject(
                title: "Sample Title",
                link: "https://example.com/image",
                media: ImageObject.Media(
                    m: "https://example.com/image.jpg"
                ),
                description: "Sample Description",
                published: "2023-06-01",
                author: "Sample Author"
            )
        ]

        repository.searchResult = .success(mockImages)

        viewModel.$images
            .dropFirst()
            .sink { images in
                XCTAssertEqual(images.count, mockImages.count)
                XCTAssertEqual(images.first?.title, mockImages.first?.title)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchImages(with: "test")

        await fulfillment(of: [expectation], timeout: 1.0)
    }

    func test_searchImages_withTag_returnsErrorOnRepositoryError() async {
        var (viewModel, repository, cancellables) = makeSUT()

        let expectation = XCTestExpectation(description: "Search images failure")
        let mockError = NSError(domain: "Test", code: 1, userInfo: nil)

        repository.searchResult = .failure(mockError)

        viewModel.$isLoading
            .dropFirst(2)
            .sink { isLoading in
                XCTAssertFalse(isLoading)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.searchImages(with: "test")

        await fulfillment(of: [expectation], timeout: 1.0)
    }

    func test_searchImages_withEmptyTag_returnsEmpty() async {
        let (viewModel, _, _) = makeSUT()

        viewModel.searchImages(with: "")

        XCTAssertTrue(viewModel.images.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }

    // MARK: - Helpers
    private func makeSUT() -> (SearchViewModel, MockSearchRepository, Set<AnyCancellable>) {
        let repository = MockSearchRepository()
        let viewModel = SearchViewModel(repository: repository)
        let cancellables: Set<AnyCancellable> = []
        return (viewModel, repository, cancellables)
    }
}

