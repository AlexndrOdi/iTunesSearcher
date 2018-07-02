//
//  SongCell.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    // MARK: - Views
    var trackNumber: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 14))
        label.widthAnchor.constraint(equalToConstant: 30).isActive = true
        label.textAlignment = .center
        return label
    }()

    var trackName: UILabel = {
        let label = UILabel(UIFont.systemFont(ofSize: 14))
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 10
        return stack
    }()

    // MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func update(track: Track) {
        if let number = track.trackNumber,
            let name = track.trackName {
            trackNumber.text = number.description
            trackName.text = name
        }
    }

    // MARK: - Private functions
    private func setup() {
        horizontalStack.addArrangedSubview(trackNumber)
        horizontalStack.addArrangedSubview(trackName)

        addSubview(horizontalStack)

        let centerY = NSLayoutConstraint(item: horizontalStack, att: .centerY, toItem: self, const: 0)
        let left = NSLayoutConstraint(item: horizontalStack, att: .leading, toItem: self, const: 8)
        let right = NSLayoutConstraint(item: horizontalStack, att: .trailing, toItem: self, const: -8)

        addConstraints([centerY, left, right])
        isUserInteractionEnabled = false
    }
}

extension SongCell: ReuseIdentifierProtocol {

}
