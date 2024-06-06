//
//  ImageObject.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation

public struct ImageObject: Identifiable, Codable, Hashable {

    public init(title: String, link: String, media: Media, description: String, published: String, author: String) {
        self.title = title
        self.link = link
        self.media = media
        self.description = description
        self.published = published
        self.author = author
    }

    public var id: String {
        return link
    }

    public var title: String
    public var link: String
    public var media: Media
    public var description: String
    public var published: String
    public var author: String

    public struct Media: Codable, Hashable {

        public var m: String

        public init(m: String) {
            self.m = m
        }
    }

    public static func == (lhs: ImageObject, rhs: ImageObject) -> Bool {
        lhs.id == rhs.id
    }
}
