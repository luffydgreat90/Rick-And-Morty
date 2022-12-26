//
//  CoreDataFeedCharacterStore+FeedStore.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/25/22.
//

import Foundation

extension CoreDataFeedCharacterStore: FeedStore {
    public func deleteCachedFeed() throws {
        try performSync { context in
            Result {
                try ManagedCache.deleteCache(in: context)
            }
        }
    }
    
    public func insert(_ feed: [LocalFeedCharacter], timestamp: Date) throws {
        try performSync { context in
            Result {
                let managedCache = try ManagedCache.newUniqueInstance(in: context)
                managedCache.timestamp = timestamp
                managedCache.feed = ManagedFeedCharacter.character(from: feed, in: context)
                try context.save()
            }
        }
    }
    
    public func retrieve() throws -> CachedFeed? {
        try performSync { context in
            Result {
                try ManagedCache.find(in: context).map {
                    CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
                }
            }
        }
    }
    
    
}
