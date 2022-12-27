//
//  ResourceLoadingView.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/27/22.
//

import Foundation

public protocol ResourceLoadingView {
    func display(_ viewModel: ResourceLoadingViewModel)
}

public struct ResourceLoadingViewModel {
    public let isLoading: Bool
}
