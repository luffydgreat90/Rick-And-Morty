//
//  HTTPURLResponse+StatusCode.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/25/22.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
