//
//  CharacterViewController.swift
//  RickAndMortyiOS
//
//  Created by Marlon Ansale on 12/31/22.
//

import UIKit
import RickAndMortyFeed

public final class CharacterViewController: UIViewController {
    @IBOutlet private(set) var characterImageView: UIImageView!
    @IBOutlet private(set) var statusLabel: UILabel!
    @IBOutlet private(set) var locationLabel: UILabel!
    
    private var delegate: FeedImageControllerDelegate?
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    public func display(_ viewModel: CharacterViewModel, delegate: FeedImageControllerDelegate) {
        self.delegate = delegate
        self.delegate?.didRequestImage()
        
        self.statusLabel.text = viewModel.status
    }
}

extension CharacterViewController: ResourceView {
    
    public typealias ResourceViewModel = UIImage
    
    public func display(_ viewModel: UIImage) {
        characterImageView.image = viewModel
    }
}

extension CharacterViewController: ResourceLoadingView, ResourceErrorView {
    public func display(_ viewModel: ResourceLoadingViewModel) {
        
    }
    
    public func display(_ viewModel: ResourceErrorViewModel) {
        
    }

}
