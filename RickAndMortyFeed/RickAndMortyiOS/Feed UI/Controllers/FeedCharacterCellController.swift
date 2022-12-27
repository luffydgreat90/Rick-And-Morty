//
//  FeedCharacterCellController.swift
//  RickAndMortyiOS
//
//  Created by Marlon Ansale on 12/27/22.
//

import UIKit
import RickAndMortyFeed

public final class FeedCharacterCellController: NSObject, UITableViewDataSource {
    private let model: FeedCharacter

    public init(model: FeedCharacter) {
        self.model = model
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
        return cell
    }
    
}


