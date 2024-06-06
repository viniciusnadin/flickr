//
//  APIResponse.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation

struct APIResponse: Codable {
    var items: [ImageObject]
}
