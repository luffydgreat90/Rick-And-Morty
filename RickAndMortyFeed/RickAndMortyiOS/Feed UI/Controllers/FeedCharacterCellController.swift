//
//  FeedCharacterCellController.swift
//  RickAndMortyiOS
//
//  Created by Marlon Ansale on 12/27/22.
//

import UIKit
import RickAndMortyFeed

public protocol FeedImageCellControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}

public final class FeedCharacterCellController: NSObject, UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    private let model: FeedCharacter
    private let delegate: FeedImageCellControllerDelegate
    public typealias ResourceViewModel = UIImage
    public init(model: FeedCharacter, delegate: FeedImageCellControllerDelegate) {
        self.model = model
        self.delegate = delegate
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedCharacterCell = tableView.dequeueReusableCell()
        cell.nameLabel.text = model.name
        cell.statusLabel.text = model.status
        cell.locationLabel.text = model.location
        cell.seenLabel.text = model.origin
        cell.feedImageView.image = nil
        return cell
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        delegate.didRequestImage()
    }
    
}

extension FeedCharacterCellController: ResourceView, ResourceLoadingView, ResourceErrorView {
    public func display(_ viewModel: UIImage) {
        
    }
    
    public func display(_ viewModel: RickAndMortyFeed.ResourceLoadingViewModel) {
        
    }
    
    public func display(_ viewModel: RickAndMortyFeed.ResourceErrorViewModel) {
        
    }
    
    
}

