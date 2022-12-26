//
//  FeedCharactersMapper.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/25/22.
//

import Foundation

public enum FeedCharactersMapper {
    private struct Root: Decodable {
        let results: [RemoteFeedCharacter]
    }
    
    private struct RemoteFeedCharacter: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let gender: String
        let image: URL
        let url: URL
        let origin: RemoteOrigin
    }
    private struct RemoteOrigin: Decodable {
        let name: String
        let url: URL
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [FeedCharacter] {
        let decoder = JSONDecoder()
        
        guard response.isOK, let root = try? decoder.decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        
        return root.results.map {
            FeedCharacter(id: $0.id,
                          name: $0.name,
                          status: $0.status,
                          species: $0.species,
                          gender: $0.gender,
                          image: $0.image,
                          url: $0.url,
                          origin: $0.origin.name,
                          originURL: $0.origin.url)
        }
    }
}
