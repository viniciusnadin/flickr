//
//  SearchRepository.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation

class SearchRepository: SearchRepositoryProtocol {
    func searchImage(_ text: String) async throws -> [ImageObject] {
        let tags = text.replacingOccurrences(of: " ", with: ",")
        let urlString = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(tags)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }

        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(APIResponse.self, from: data)
        return response.items
    }
}
