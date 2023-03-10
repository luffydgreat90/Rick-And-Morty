//
//  FeedCacheTestHelpers.swift
//  RickAndMortyFeedTests
//
//  Created by Marlon Ansale on 12/26/22.
//

import Foundation
import RickAndMortyFeed

func uniqueCharacter(_ id:Int) -> FeedCharacter {
    FeedCharacter(id: id,
                 name: "Rick \(id)",
                 status: "Alive",
                 species: "Human",
                 gender: "Non-Binary",
                 image: anyURL(),
                 url: anyURL(),
                 origin: "Earth",
                 originURL: anyURL(),
                 location: "Citadel of Ricks",
                 locationURL: anyURL())
}

func uniqueCharacterFeed() -> (models: [FeedCharacter], local: [LocalFeedCharacter]) {
    let models = [uniqueCharacter(1),uniqueCharacter(2)]
    let local = models.map {
        LocalFeedCharacter(id: $0.id, name: $0.name, status: $0.status, species: $0.species, gender: $0.gender, image: $0.image, url: $0.url, origin: $0.origin, originURL: $0.originURL, location: $0.location, locationURL: $0.locationURL)
    }
    return (models, local)
}
