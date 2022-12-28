//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Marlon Ansale on 12/25/22.
//

import UIKit
import Combine
import RickAndMortyFeed
import RickAndMortyiOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var cancel: Cancellable?

    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession.shared)
    }()
    private lazy var baseURL = URL(string: "https://rickandmortyapi.com/api")!
    
    private lazy var navigationController = UINavigationController(
        rootViewController: FeedUIComposer.feedComposedWith(feedLoader: makeRemoteFeedLoaderWithLocalFallback,
                                                            imageLoader: makeLocalImageLoaderWithRemoteFallback))

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    
    private func makeRemoteFeedLoaderWithLocalFallback() -> AnyPublisher<[FeedCharacter], Error> {
        let url = FeedEndpoint.get.url(baseURL: baseURL)

        return httpClient
            .getPublisher(url: url)
            .tryMap(FeedCharactersMapper.map)
            .eraseToAnyPublisher()
    }
    
    private func makeLocalImageLoaderWithRemoteFallback(url: URL) -> ImageDataLoader.Publisher {
        return Future { promise in
            promise(.failure(NSErrorDomain(string: "not yet") as! Error))
        }.eraseToAnyPublisher()
    }
}
