//
//  LoadResourcePresenter.swift
//  RickAndMortyFeed
//
//  Created by Marlon Ansale on 12/26/22.
//

import Foundation

public protocol ResourceView {
    associatedtype ResourceViewModel

    func display(_ viewModel: ResourceViewModel)
}

public final class LoadResourcePresenter<Resource, View: ResourceView> {
    public typealias Mapper = (Resource) throws -> View.ResourceViewModel
}
