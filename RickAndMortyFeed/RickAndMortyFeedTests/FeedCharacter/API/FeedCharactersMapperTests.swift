//
//  RickAndMortyFeedTests.swift
//  RickAndMortyFeedTests
//
//  Created by Marlon Ansale on 12/25/22.
//

import XCTest
import RickAndMortyFeed

final class FeedItemMapperTests: XCTestCase {

    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = anyData()
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try FeedCharactersMapper.map(json, from: HTTPURLResponse(statusCode: code)),
                "code is \(code)"
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try FeedCharactersMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeItemsJSON([])
        
        let result = try FeedCharactersMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        let item1 = makeItem(id: 1)
        let item2 = makeItem(id: 2)
        
        let json = makeItemsJSON([item1.json, item2.json])
        
        let result = try FeedCharactersMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
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
