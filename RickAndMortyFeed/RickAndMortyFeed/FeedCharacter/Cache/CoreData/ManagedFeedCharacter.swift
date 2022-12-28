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
    @NSManaged var origin: String
    @NSManaged var originURL: URL
    @NSManaged var location: String
    @NSManaged var locationURL: URL
}

extension ManagedFeedCharacter {
    var local: LocalFeedCharacter {
        return LocalFeedCharacter(id: Int(id), name: name, status: status, species: species, gender: gender, image: image, url: url, origin: origin, originURL: originURL, location: location, locationURL: locationURL)
    }
    
    static func character(from localFeed: [LocalFeedCharacter], in context: NSManagedObjectContext) -> NSOrderedSet {
        let images = NSOrderedSet(array: localFeed.map { local in
            let managed = ManagedFeedCharacter(context: context)
            managed.id = Int64(local.id)
            managed.name = local.name
            managed.gender = local.gender
            managed.species = local.species
            managed.status = local.status
            managed.image = local.image
            managed.url = local.url
            managed.data = context.userInfo[local.url] as? Data
            managed.origin = local.origin
            managed.originURL = local.originURL
            managed.location = local.location
            managed.locationURL = local.locationURL
            return managed
        })
        context.userInfo.removeAllObjects()
        return images
    }
    
    static func first(with url: URL, in context: NSManagedObjectContext) throws -> ManagedFeedCharacter? {
        let request = NSFetchRequest<ManagedFeedCharacter>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedFeedCharacter.url), url])
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
    
    static func data(with url: URL, in context: NSManagedObjectContext) throws -> Data? {
        if let data = context.userInfo[url] as? Data { return data }
        
        return try first(with: url, in: context)?.data
    }
}
