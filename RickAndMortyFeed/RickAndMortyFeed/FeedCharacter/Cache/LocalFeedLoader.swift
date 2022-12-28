//
//  LocalFeedLoader.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/28/22.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date
    
    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
}
