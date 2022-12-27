//
//  CharacterCellController.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/26/22.
//

import UIKit

public struct CharacterCellController {
    let id: AnyHashable
    let dataSource: UITableViewDataSource
    let delegate: UITableViewDelegate?
    let dataSourcePrefetching: UITableViewDataSourcePrefetching?
    
    public init(id: AnyHashable, _ dataSource: UITableViewDataSource & UITableViewDelegate & UITableViewDataSourcePrefetching) {
        self.id = id
        self.dataSource = dataSource
        self.delegate = dataSource
        self.dataSourcePrefetching = dataSource
    }
}

extension CharacterCellController: Equatable {
    public static func == (lhs: CharacterCellController, rhs: CharacterCellController) -> Bool {
        lhs.id == rhs.id
    }
}

extension CharacterCellController: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
