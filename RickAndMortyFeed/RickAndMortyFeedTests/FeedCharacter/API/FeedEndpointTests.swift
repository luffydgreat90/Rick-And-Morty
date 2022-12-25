//
//  FeedEndpointTests.swift
//  RickAndMortyFeedTests
//
//  Created by Marlon Ansale on 12/25/22.
//

import XCTest
import RickAndMortyFeed

class FeedEndpointTests: XCTestCase {
    func test_feed_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!

        let received = FeedEndpoint.get.url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/character")!

        XCTAssertEqual(received, expected)
    }
}
