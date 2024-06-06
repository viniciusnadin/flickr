//
//  DateFormatter.swift
//  FlickrSearcher
//
//  Created by Vinicius Nadin on 06/06/24.
//

import Foundation

enum StringDateFormatter {
    static func formattedDate(from dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .none
            return displayFormatter.string(from: date)
        }
        return dateString
    }
}
