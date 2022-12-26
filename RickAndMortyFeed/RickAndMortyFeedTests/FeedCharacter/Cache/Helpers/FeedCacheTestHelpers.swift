//
//  FeedCacheTestHelpers.swift
//  RickAndMortyFeedTests
//
//  Created by Marlon Ansale on 12/26/22.
//

import Foundation
import RickAndMortyFeed

func uniqueCharacter() -> FeedCharacter {
    FeedCharacter(id: Int.random(in: 0...1000),
                 name: "Rick",
                 status: "Alive",
                 species: "Human",
                 gender: "Non-Binary",
                 image: anyURL(),
                 url: anyURL())
}

func uniqueCharacterFeed() -> (models: [FeedCharacter], local: [LocalFeedCharacter]) {
    let models = [uniqueCharacter(), uniqueCharacter()]
    let local = models.map { LocalFeedCharacter(id: $0.id,
                                                name: $0.name,
                                                status: $0.status,
                                                species: $0.species,
                                                gender: $0.gender,
                                                image: $0.image,
                                                url: $0.url)
        
    }
    return (models, local)
}
