//
//  ImageDetailViewModel.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation

public class ImageDetailViewModel {
    private let image: ImageObject

    public var imagePath: String {
        image.media.m
    }

    public var imageTitle: String {
        image.title
    }

    public var imageDescription: String {
        image.description
    }

    public var imagePublicationDate: String {
        "Published: \(StringDateFormatter.formattedDate(from: image.published))"
    }

    public init(image: ImageObject) {
        self.image = image
    }
}
