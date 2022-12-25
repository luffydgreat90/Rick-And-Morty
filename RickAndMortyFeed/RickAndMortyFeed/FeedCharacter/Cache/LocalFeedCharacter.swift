//
//  LocalFeedCharacter.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/25/22.
//

import Foundation

public struct LocalFeedCharacter: Equatable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let image: URL
    public let url: URL
    
    public init(id: Int, name: String, status: String, species: String, gender: String, image: URL, url: URL) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
        self.url = url
    }
}
