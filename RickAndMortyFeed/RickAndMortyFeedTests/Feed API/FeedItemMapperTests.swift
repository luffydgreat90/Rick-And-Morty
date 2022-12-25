//
//  RickAndMortyFeedTests.swift
//  RickAndMortyFeedTests
//
//  Created by Marlon Ansale on 12/25/22.
//

import XCTest

public struct FeedCharacter: Equatable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let image: URL
    public let url: URL
}

public enum FeedItemsMapper {
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
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [FeedCharacter] {
        let decoder = JSONDecoder()
        
        guard response.statusCode == 200, let root = try? decoder.decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        
        return root.results.map {
            FeedCharacter(id: $0.id,
                          name: $0.name,
                          status: $0.status,
                          species: $0.species,
                          gender: $0.gender,
                          image: $0.image,
                          url: $0.url)
        }
    }
}

final class FeedItemMapperTests: XCTestCase {

    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = anyData()
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try FeedItemsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try FeedItemsMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeItemsJSON([])
        
        let result = try FeedItemsMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        let item1 = makeItem(id: 1)
        let item2 = makeItem(id: 2)
        
        let json = makeItemsJSON([item1.json, item2.json])
        
        let result = try FeedItemsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [item1.model, item2.model])
    }
    
    
    private func makeItem(id: Int, name: String = "Rick", status: String = "alive", species: String = "human", gender: String = "unknown", image: URL = anyURL(), url: URL = anyURL(), created: Date = Date()) -> (model: FeedCharacter, json: [String: Any]) {
        let item = FeedCharacter(id: id, name: name, status: status, species: species, gender: gender, image: image, url: url)
        
        let json = [
            "id": id,
            "name": name,
            "status": status,
            "species": species,
            "gender": gender,
            "image": image.absoluteString,
            "url": url.absoluteString,
            "created": "2017-11-04T18:48:46.250Z"
        ].compactMapValues { $0 }
        
        return (item, json)
    }
}
