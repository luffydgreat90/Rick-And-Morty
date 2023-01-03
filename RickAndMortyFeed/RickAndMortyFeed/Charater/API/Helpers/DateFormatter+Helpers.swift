//
//  DateFormatter+Helpers.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 1/3/23.
//

import Foundation

public extension DateFormatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
      }()
}
