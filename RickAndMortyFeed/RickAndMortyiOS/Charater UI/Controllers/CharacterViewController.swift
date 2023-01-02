//
//  CharacterViewController.swift
//  RickAndMortyiOS
//
//  Created by Marlon Ansale on 12/31/22.
//

import UIKit
import RickAndMortyFeed

public final class CharacterViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func display(_ viewModel: CharacterViewModel) {
        
    }
}

extension CharacterViewController: ResourceView {
    
    public typealias ResourceViewModel = UIImage
    
    public func display(_ viewModel: UIImage) {
        
    }
}

extension CharacterViewController: ResourceLoadingView, ResourceErrorView {
    public func display(_ viewModel: RickAndMortyFeed.ResourceLoadingViewModel) {
        
    }
    
    public func display(_ viewModel: RickAndMortyFeed.ResourceErrorViewModel) {
        
    }

}
