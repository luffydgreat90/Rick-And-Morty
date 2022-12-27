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

public final class FeedUIComposer {
    private init() {}
    
    private typealias FeedsPresentationAdapter = LoadResourcePresentationAdapter<[FeedCharacter], FeedViewAdapter>
    
    public static func feedComposedWith(
        feedLoader: @escaping () -> AnyPublisher<[FeedCharacter], Error>
    ) -> FeedViewController {
        
        let adapter = FeedsPresentationAdapter(loader: feedLoader)
        let viewController = makeCommentsViewController(title: FeedCharacterPresenter.title)
        adapter.presenter = LoadResourcePresenter(resourceView: FeedViewAdapter(controller: viewController),
                                                  loadingView: WeakRefVirtualProxy(viewController),
                                                  errorView: WeakRefVirtualProxy(viewController),
                                                  mapper: { FeedCharacterPresenter.map($0)})
        return viewController
    }
    
    private static func makeCommentsViewController(title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! FeedViewController
        controller.title = title
        return controller
    }
}
