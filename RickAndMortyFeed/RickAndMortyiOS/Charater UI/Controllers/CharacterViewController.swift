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
    
    public var onLoadImage: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    public func display(_ viewModel: CharacterViewModel) {
        self.statusLabel.text = viewModel.status
        self.locationLabel.text = viewModel.location
        onLoadImage?()
    }
    
    private func setupView(){
        characterImageView.layer.cornerRadius = 16.0
        characterImageView.layer.masksToBounds = true
        characterImageView.clipsToBounds = true
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
