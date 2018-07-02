//
//  NotFoundCell.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 29.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class NotFoundCell: UICollectionReusableView {

    // MARK: - Views
    let noResultsLabel: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 18))
        label.textAlignment = .center
        label.text = Consts.SearchBar.noResults.rawValue
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func update(empty: Bool) {
        noResultsLabel.isHidden = !empty
    }

    // MARK: - Private functions
    private func setup() {
        addSubview(noResultsLabel)

        let centerY = NSLayoutConstraint(item: noResultsLabel, att: .centerY, toItem: self, const: 0)
        let centerX = NSLayoutConstraint(item: noResultsLabel, att: .centerX, toItem: self, const: 0)
        backgroundColor = UIColor.white
        addConstraints([centerX, centerY])
    }
}
extension NotFoundCell: ReuseIdentifierProtocol {

}
