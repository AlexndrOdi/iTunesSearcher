//
//  HeaderWithSearchBarCell.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class HeaderWithSearchBarCell: UICollectionViewCell {

    //Views
    let searchbar: UISearchBar = {
        let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.isTranslucent = true
        bar.searchBarStyle = .minimal
        bar.placeholder = Consts.SearchBar.title.rawValue
        return bar
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private functions
    private func setup() {
        addSubview(searchbar)

        let left = NSLayoutConstraint(item: searchbar, att: .leading, toItem: self, const: 0)
        let right = NSLayoutConstraint(item: searchbar, att: .trailing, toItem: self, const: 0)
        let top = NSLayoutConstraint(item: searchbar, att: .top, toItem: self, const: 0)
        let bottom = NSLayoutConstraint(item: searchbar, att: .bottom, toItem: self, const: 0)

        addConstraints([left, top, right, bottom])
    }
}

extension HeaderWithSearchBarCell: ReuseIdentifierProtocol {

}
