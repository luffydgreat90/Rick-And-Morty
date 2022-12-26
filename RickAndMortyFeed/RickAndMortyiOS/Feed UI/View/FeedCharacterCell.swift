//
//  FeedCharacterCell.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/26/22.
//

import UIKit

public final class FeedCharacterCell: UITableViewCell {
    @IBOutlet public private(set) var feedImageView: UIImageView!
    @IBOutlet public private(set) var nameLabel: UILabel!
    @IBOutlet public private(set) var statusLabel: UILabel!
    @IBOutlet public private(set) var knowLocationLabel: UILabel!
    @IBOutlet public private(set) var locationLabel: UILabel!
    @IBOutlet public private(set) var firstSeenLabel: UILabel!
    @IBOutlet public private(set) var seenLabel: UILabel!
}
