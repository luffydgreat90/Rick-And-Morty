//
//  ImageDataStore.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/28/22.
//

import Foundation

public protocol ImageDataStore {
    func insert(_ data: Data, for url: URL) throws
    func retrieve(dataForURL url: URL) throws -> Data?
}
