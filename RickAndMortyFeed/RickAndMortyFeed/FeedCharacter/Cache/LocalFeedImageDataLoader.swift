//
//  LocalFeedImageDataLoader.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/28/22.
//

import Foundation

public protocol CharacterImageDataCache {
    func save(_ data: Data, for url: URL) throws
}

public final class LocalFeedImageDataLoader {
    private let store: ImageDataStore
    
    public init(store: ImageDataStore) {
        self.store = store
    }
}

extension LocalFeedImageDataLoader: CharacterImageDataCache {
    public enum SaveError: Error {
        case failed
    }
    
    public func save(_ data: Data, for url: URL) throws {
        do {
            try store.insert(data, for: url)
        } catch {
            throw SaveError.failed
        }
    }
}

extension LocalFeedImageDataLoader: ImageDataLoader {
    public enum LoadError: Error {
        case failed
        case notFound
    }
    
    public func loadImageData(from url: URL) throws -> Data {
        do {
            if let imageData = try store.retrieve(dataForURL: url) {
                return imageData
            }
        } catch {
            throw LoadError.failed
        }
        
        throw LoadError.notFound
    }
}
