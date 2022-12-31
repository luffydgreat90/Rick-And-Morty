//
//  EpisodeEndpoint.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/31/22.
//

import Foundation

public enum EpisodeEndpoint {
    case get(Int)

    public func url(baseURL: URL) -> URL {
        switch self {
        case .get(episodeID):
            return baseURL.appendingPathComponent("/episode/\(episodeID)")
        }
    }
}
