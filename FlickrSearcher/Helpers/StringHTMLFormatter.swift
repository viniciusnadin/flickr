//
//  StringHTMLFormatter.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation

extension String {
    func strippingHTML() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
        return attributedString?.string ?? self
    }

    func extractFinalPart() -> String {
        let strippedText = self.strippingHTML()
        let paragraphs = strippedText.split(separator: "\n").map { String($0) }
        return paragraphs.last ?? strippedText
    }
}
