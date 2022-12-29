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
    
    private typealias ImageDataPresentationAdapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedCharacterCellController>>
    
    init(controller: FeedViewController? = nil, imageLoader: @escaping (URL) -> ImageDataLoader.Publisher) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.display(viewModel.feed.map { viewModel in
            
            let feedCharacterCell = FeedCharacterCellController(model: viewModel,
                                                        delegate: ImageDataPresentationAdapter.init(loader: { [imageLoader] in
                                                              return  imageLoader(viewModel.image)
                           }))
            
           
           
            return CharacterCellController(id: viewModel,feedCharacterCell)
        })
    }
}


