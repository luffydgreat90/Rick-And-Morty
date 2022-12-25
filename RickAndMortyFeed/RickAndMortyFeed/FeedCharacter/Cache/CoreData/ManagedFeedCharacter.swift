//
//  ManagedFeedCharacter.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/25/22.
//

import CoreData

@objc(ManagedFeedCharacter)
class ManagedFeedCharacter: NSManagedObject {
    @NSManaged var id: Int64
    @NSManaged var name: String
    @NSManaged var gender: String
    @NSManaged var species: String
    @NSManaged var status: String
    @NSManaged var data: Data?
    @NSManaged var image: URL
    @NSManaged var url: URL
    @NSManaged var cache: ManagedCache
}


