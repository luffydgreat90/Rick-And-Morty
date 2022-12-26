//
//  FeedCharacter.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/25/22.
//

import Foundation

public struct FeedCharacter: Hashable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let image: URL
    public let url: URL
    public let origin: String
    public let originURL: URL
    public let location: String
    public let locationURL: URL
    
    public init(id: Int, name: String, status: String, species: String, gender: String, image: URL, url: URL, origin: String, originURL: URL, location: String, locationURL: URL) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
        self.url = url
        self.origin = origin
        self.originURL = originURL
        self.location = location
        self.locationURL = locationURL
    }
}
