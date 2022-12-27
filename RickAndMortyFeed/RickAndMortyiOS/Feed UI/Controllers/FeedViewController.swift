//
//  FeedViewController.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/26/22.
//

import UIKit
import RickAndMortyFeed

public final class FeedViewController: UITableViewController {
    
    private lazy var dataSource: UITableViewDiffableDataSource<Int, CharacterCellController> = {
        .init(tableView: tableView) { (tableView, index, controller) in
            controller.dataSource.tableView(tableView, cellForRowAt: index)
        }
    }()
    
    public var onRefresh: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        onRefresh?()
    }
    
    private func configureTableView() {
        dataSource.defaultRowAnimation = .fade
        tableView.dataSource = dataSource
    }
    
    public func display(_ cellControllers: [CharacterCellController]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CharacterCellController>()
        snapshot.appendSections([0])
        snapshot.appendItems(cellControllers, toSection: 0)
        dataSource.apply(snapshot)
    }
}

extension FeedViewController: ResourceLoadingView {
    public func display(_ viewModel: RickAndMortyFeed.ResourceLoadingViewModel) {
        
    }
}

extension FeedViewController: ResourceErrorView {
    public func display(_ viewModel: RickAndMortyFeed.ResourceErrorViewModel) {
    
    }
}
