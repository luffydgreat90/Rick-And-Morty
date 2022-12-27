//
//  FeedCharacterPresenter.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/27/22.
//

import Foundation

public final class FeedCharacterPresenter {
    public static var title: String {
        NSLocalizedString(
            "FEED_TITLE",
            tableName: "Feed",
            bundle: Bundle(for: FeedCharacterPresenter.self),
            comment: "Title for the feed view")
    }

    public static func map(_ feed: [FeedCharacter]) -> FeedViewModel {
        FeedViewModel(feed: feed)
    }
}
