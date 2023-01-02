//
//  FeedUIComposer.swift
//  RickAndMorty
//
//  Created by Marlon Ansale on 12/27/22.
//

import UIKit
import Combine
import RickAndMortyFeed
import RickAndMortyiOS

public enum FeedUIComposer {
    private typealias FeedsPresentationAdapter = LoadResourcePresentationAdapter<[FeedCharacter], FeedViewAdapter>
    
    public static func feedComposeWith(
        feedLoader: @escaping () -> AnyPublisher<[FeedCharacter], Error>,
        imageLoader: @escaping (URL) -> AnyPublisher<Data, Error>,
        selection: @escaping (FeedCharacter) -> Void
    ) -> FeedViewController {
        let viewController = makeFeedViewController(title: FeedCharacterPresenter.title)
        let adapter = FeedsPresentationAdapter(loader: feedLoader)
        viewController.onRefresh = adapter.loadResource
        
        adapter.presenter = LoadResourcePresenter(resourceView: FeedViewAdapter(
            controller: viewController,
            imageLoader: imageLoader,
            selection: selection
            ), loadingView: WeakRefVirtualProxy(viewController),
               errorView: WeakRefVirtualProxy(viewController),
               mapper: { FeedCharacterPresenter.map($0) })
        
        return viewController
    }
    
    private static func makeFeedViewController(title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! FeedViewController
        controller.title = title
        return controller
    }
}
