//
//  CoreDataFeedCharacterStore+ImageDataStore.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/28/22.
//

import Foundation
import CoreData

extension CoreDataFeedCharacterStore: ImageDataStore {
    public func insert(_ data: Data, for url: URL) throws {
        try performSync { context in
            Result {
                try ManagedFeedCharacter.first(with: url, in: context)
                    .map { $0.data = data }
                    .map(context.save)
            }
        }
    }
    
    public func retrieve(dataForURL url: URL) throws -> Data? {
        try performSync { context in
            Result {
                try ManagedFeedCharacter.data(with: url, in: context)
            }
        }
    }
}
