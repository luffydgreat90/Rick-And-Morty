//
//  FeedCharacterCellController.swift
//  RickAndMortyiOS
//
//  Created by Marlon Ansale on 12/27/22.
//

import UIKit
import RickAndMortyFeed

public protocol ImageControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}

public final class FeedCharacterCellController: NSObject, UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    private let model: FeedCharacter
    private let delegate: ImageControllerDelegate
    public typealias ResourceViewModel = UIImage
    private var cell: FeedCharacterCell?
    private let selection: (FeedCharacter) -> Void
    
    public init(
        model: FeedCharacter,
        delegate: ImageControllerDelegate,
        selection:@escaping (FeedCharacter) -> Void) {
        self.model = model
        self.delegate = delegate
        self.selection = selection
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        cell?.bind(model: model)
        delegate.didRequestImage()
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        delegate.didRequestImage()
    }

    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelLoad()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection(model)
    }
    
    private func cancelLoad() {
        releaseCellForReuse()
        delegate.didCancelImageRequest()
    }
    
    private func releaseCellForReuse() {
        cell = nil
    }
}

extension FeedCharacterCellController: ResourceView, ResourceLoadingView, ResourceErrorView {
    public func display(_ viewModel: UIImage) {
        cell?.feedImageView.backgroundColor = .clear
        cell?.feedImageView.image = viewModel
    }
    
    public func display(_ viewModel: ResourceLoadingViewModel) {
    
    }
    
    public func display(_ viewModel: ResourceErrorViewModel) {
        cell?.feedImageView.backgroundColor = .gray
    }
}

