//
//  FeedStore.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/25/22.
//

import Foundation

public typealias CachedFeed = (feed: [LocalFeedCharacter], timestamp: Date)

public protocol FeedStore {
    func deleteCachedFeed() throws
    func insert(_ feed: [LocalFeedCharacter], timestamp: Date) throws
    func retrieve() throws -> CachedFeed?
}
