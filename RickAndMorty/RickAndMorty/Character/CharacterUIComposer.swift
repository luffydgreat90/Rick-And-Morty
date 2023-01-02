//
//  CharacterUIComposer.swift
//  RickAndMorty
//
//  Created by Marlon Ansale on 12/31/22.
//

import UIKit
import Combine
import RickAndMortyFeed
import RickAndMortyiOS

public enum CharacterUIComposer {

    public static func characterComposeWith(
        character:CharacterViewModel,
        imageLoader: @escaping (URL) -> ImageDataLoader.Publisher) -> CharacterViewController {
        let viewController = makeCharacterViewController(title: character.title)
        return viewController
    }
    
    private static func makeCharacterViewController(title: String) -> CharacterViewController {
        let bundle = Bundle(for: CharacterViewController.self)
        let storyboard = UIStoryboard(name: "Character", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! CharacterViewController
        controller.title = title
        return controller
    }

}

public final class CharacterAdapter {
    private let imageLoader: (URL) -> ImageDataLoader.Publisher
    private weak var controller: CharacterViewController?
    
    private typealias ImageDataPresentationAdapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedCharacterCellController>>
    
    init(controller: CharacterViewController? = nil,
        imageLoader: @escaping (URL) -> ImageDataLoader.Publisher) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: CharacterViewModel) {
        
    }
}
