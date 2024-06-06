//
//  ImageDetailViewModelTests.swift
//  FlickrSearcherTests
//
//  Created by Vinicius Nadin on 06/06/24.
//

import XCTest
import FlickrSearcher

final class ImageDetailViewModelTests: XCTestCase {

    func testImagePath() {
        let image = ImageObject(
            title: "Sample Title",
            link: "https://example.com/image",
            media: ImageObject.Media(
                m: "https://example.com/image.jpg"
            ),
            description: "Sample Description",
            published: "2023-06-01",
            author: "Sample Author"
        )
        let viewModel = ImageDetailViewModel(image: image)

        XCTAssertEqual(viewModel.imagePath, "https://example.com/image.jpg")
        XCTAssertEqual(viewModel.imageTitle, "Title: Sample Title")
        XCTAssertEqual(viewModel.imageDescription, "Description: Sample Description")
        XCTAssertEqual(viewModel.imageAuthor, "Author: Sample Author")
        XCTAssertEqual(viewModel.imagePublicationDate, "Published: 2023-06-01")
        XCTAssertEqual(viewModel.viewTitle, "Photo Details")
    }
}
