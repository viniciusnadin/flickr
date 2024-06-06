//
//  SearchRepositoryProtocol.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation

public protocol SearchRepositoryProtocol {
    func searchImage(_ text: String) async throws -> [Image]
}
