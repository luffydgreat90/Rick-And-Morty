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
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
    
    init(controller: FeedViewController? = nil, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.display(viewModel.feed.map { viewModel in
            CharacterCellController(id: viewModel, FeedCharacterCellController(model: viewModel))
        })
    }
}
