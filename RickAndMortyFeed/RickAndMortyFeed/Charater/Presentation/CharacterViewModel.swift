//
//  CharacterViewModel.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/31/22.
//

import Foundation

public struct CharacterViewModel {
    public let title: String
    public let status: String
    public let image:URL
    
    public init(title:String, status:String, image:URL) {
        self.title = title
        self.status = status
        self.image = image
    }
}
