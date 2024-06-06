//
//  StringHTMLFormatter.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation

extension String {
    func convertHTMLToAttributedString(completion: @escaping (AttributedString) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = self.data(using: .utf8) else {
                DispatchQueue.main.async {
                    completion(AttributedString())
                }
                return
            }

            if let attributedString = try? NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil) {

                let attributedString = AttributedString(attributedString)
                DispatchQueue.main.async {
                    completion(attributedString)
                }
            } else {
                DispatchQueue.main.async {
                    completion(AttributedString())
                }
            }
        }
    }
}
