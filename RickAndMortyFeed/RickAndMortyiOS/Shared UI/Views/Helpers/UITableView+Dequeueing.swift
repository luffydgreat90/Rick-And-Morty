//
//  UITableView+Dequeueing.swift
//  RickAndMortyiOS
//
//  Created by Marlon Ansale on 12/27/22.
//

import UIKit.UITableView

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}

