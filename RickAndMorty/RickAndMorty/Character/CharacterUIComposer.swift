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
    private typealias ImageDataPresentationAdapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<CharacterViewController>>
    
    public static func characterComposeWith(
        character:CharacterViewModel,
        imageLoader: @escaping (URL) -> ImageDataLoader.Publisher) -> CharacterViewController {
            
            let viewController = makeCharacterViewController(title: character.title)
        
            let adapter = ImageDataPresentationAdapter(loader: { [imageLoader] in
                imageLoader(character.image) }
            )
            
            adapter.presenter = LoadResourcePresenter(
                resourceView: WeakRefVirtualProxy(viewController),
                loadingView: WeakRefVirtualProxy(viewController),
                errorView: WeakRefVirtualProxy(viewController),
                mapper: UIImage.tryMake)
            
            viewController.display(character, delegate: adapter)
        
            return viewController
    }
    
    private static func makeCharacterViewController(title: String) -> CharacterViewController {
        let bundle = Bundle(for: CharacterViewController.self)
        let storyboard = UIStoryboard(name: "Character", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! CharacterViewController
        controller.title = title
        controller.loadViewIfNeeded()
        return controller
    }

}
