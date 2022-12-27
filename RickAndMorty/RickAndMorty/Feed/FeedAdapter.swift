//
//  FeedAdapter.swift
//  RickAndMorty
//
//  Created by Marlon Ansale on 12/27/22.
//

import UIKit
import RickAndMortyFeed
import RickAndMortyiOS

final class FeedViewAdapter: ResourceView {
    private weak var controller: FeedViewController?
    
    init(controller: FeedViewController? = nil) {
        self.controller = controller
    }
    
    func display(_ viewModel: FeedViewModel) {
        controller?.display(viewModel.feed.map { viewModel in
            CharacterCellController(id: viewModel, FeedCharacterCellController(model: viewModel))
        })
    }
}
