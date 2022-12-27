//
//  FeedImageDataLoader.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/27/22.
//

import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
