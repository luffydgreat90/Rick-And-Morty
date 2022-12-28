//
//  ImageDataLoader.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/27/22.
//

import Foundation

public protocol ImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
