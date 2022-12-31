//
//  SceneDelegate.swift
//  RickAndMorty
//
//  Created by Marlon Ansale on 12/25/22.
//

import UIKit
import Combine
import CoreData
import RickAndMortyFeed
import RickAndMortyiOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var scheduler: AnyDispatchQueueScheduler = DispatchQueue(
        label: "com.essentialdeveloper.infra.queue",
        qos: .userInitiated,
        attributes: .concurrent
    ).eraseToAnyScheduler()
    
    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession.shared)
    }()
    
    private lazy var baseURL = URL(string: "https://rickandmortyapi.com/api")!
    
    private lazy var navigationController = UINavigationController(
        rootViewController: FeedUIComposer.feedComposeWith(
            feedLoader: makeRemoteFeedLoaderWithLocalFallback,
            imageLoader: makeLocalImageLoaderWithRemoteFallback))
    
    private lazy var store: FeedStore & ImageDataStore = {
        do {
            return try CoreDataFeedCharacterStore(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("feed-character-store.sqlite"))
        } catch {
            fatalError("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
        }
    }()

    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store, currentDate: Date.init)
    }()
    
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
        let localImageLoader = LocalFeedImageDataLoader(store: store)
    
        return localImageLoader.loadImageDataPublisher(from: url)
            .fallback { [httpClient, scheduler] in
                httpClient.getPublisher(url: url)
                    .tryMap(ImageDataMapper.map)
                    .caching(to: localImageLoader, using: url)
                    .subscribe(on: scheduler)
                    .eraseToAnyPublisher()
            }.subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }
}
