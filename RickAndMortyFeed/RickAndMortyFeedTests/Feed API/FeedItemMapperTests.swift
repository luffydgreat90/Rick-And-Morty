//
//  RickAndMortyFeedTests.swift
//  RickAndMortyFeedTests
//
//  Created by Marlon Ansale on 12/25/22.
//

import XCTest

public struct FeedCharacter {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let gender: String
    public let image: URL
    public let url: URL
    public let created: Date
}

public enum FeedItemsMapper {
    private struct Root: Decodable {
        let result: [RemoteFeedCharacter]
    }
    
    private struct RemoteFeedCharacter: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let gender: String
        let image: URL
        let url: URL
        let created: Date
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [FeedCharacter] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard response.statusCode == 200, let root = try? decoder.decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        
        return root.result.map {
            FeedCharacter(id: $0.id,
                          name: $0.name,
                          status: $0.status,
                          species: $0.species,
                          gender: $0.gender,
                          image: $0.image,
                          url: $0.url,
                          created: $0.created)
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
    
}
