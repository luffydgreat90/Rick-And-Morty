//
//  FeedCharacterCell.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/26/22.
//

import UIKit
import RickAndMortyFeed

public final class FeedCharacterCell: UITableViewCell {
    @IBOutlet public private(set) var feedImageView: UIImageView!
    @IBOutlet public private(set) var nameLabel: UILabel!
    @IBOutlet public private(set) var statusLabel: UILabel!
    @IBOutlet public private(set) var knowLocationLabel: UILabel!
    @IBOutlet public private(set) var locationLabel: UILabel!
    @IBOutlet public private(set) var firstSeenLabel: UILabel!
    @IBOutlet public private(set) var seenLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        feedImageView.layer.cornerRadius = 16.0
        feedImageView.layer.masksToBounds = true
        feedImageView.clipsToBounds = true
    }
    
    public func bind(model: FeedCharacter) {
        nameLabel.text = model.name
        statusLabel.text = model.status
        locationLabel.text = model.location
        seenLabel.text = model.origin
        feedImageView.image = nil
    }
}
