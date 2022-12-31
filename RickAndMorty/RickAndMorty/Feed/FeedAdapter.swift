//
//  FeedAdapter.swift
//  RickAndMorty
//
//  Created by Marlon Ansale on 12/27/22.
//

import UIKit
import Combine
import RickAndMortyFeed
import RickAndMortyiOS

final class FeedViewAdapter: ResourceView {
    private weak var controller: FeedViewController?
    private let imageLoader: (URL) -> ImageDataLoader.Publisher
    private let selection: (FeedCharacter) -> Void
    private typealias ImageDataPresentationAdapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedCharacterCellController>>
    
    init(
        controller: FeedViewController? = nil,
        imageLoader: @escaping (URL) -> ImageDataLoader.Publisher,
        selection: @escaping (FeedCharacter) -> Void) {
        self.controller = controller
        self.imageLoader = imageLoader
        self.selection = selection
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.display(viewModel.feed.map { viewModel in
            
            let imagePresenter = ImageDataPresentationAdapter.init(loader: { [imageLoader] in
                imageLoader(viewModel.image) })
            
            
            let feedCharacterCell = FeedCharacterCellController(model: viewModel,
                                                        delegate: imagePresenter)
            
            imagePresenter.presenter = LoadResourcePresenter(
                resourceView: WeakRefVirtualProxy(feedCharacterCell),
                loadingView: WeakRefVirtualProxy(feedCharacterCell),
                errorView: WeakRefVirtualProxy(feedCharacterCell),
                mapper: UIImage.tryMake)
           
            return CharacterCellController(id: viewModel,feedCharacterCell)
        })
    }
}

extension UIImage {
    struct InvalidImageData: Error {}
    
    static func tryMake(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw InvalidImageData()
        }
        return image
    }
}
