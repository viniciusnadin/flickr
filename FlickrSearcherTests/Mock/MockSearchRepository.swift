//
//  MockSearchRepository.swift
//  FlickrSearcherTests
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation
import FlickrSearcher

class MockSearchRepository: SearchRepositoryProtocol {
    var searchResult: Result<[ImageObject], Error>?

    func searchImage(_ tags: String) async throws -> [ImageObject] {
        if let result = searchResult {
            switch result {
            case .success(let images):
                return images
            case .failure(let error):
                throw error
            }
        }
        return []
    }
}
