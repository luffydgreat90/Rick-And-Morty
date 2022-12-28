//
//  UIRefreshControl+Helpers.swift
//  RickAndMortyiOS
//
//  Created by Marlon Ansale on 12/28/22.
//

import UIKit.UIRefreshControl

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
