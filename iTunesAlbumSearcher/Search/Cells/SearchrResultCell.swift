//
//  SearchrResultCell.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 26.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class SearchrResultCell: UICollectionViewCell {

    // MARK: - Views
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 90).isActive = true
        image.heightAnchor.constraint(equalToConstant: 90).isActive = true
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        image.backgroundColor = UIColor.lightGray
        return image
    }()

    let nameLabel: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 12))
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    let genreLabel: UILabel = {
        let label = UILabel(UIFont.systemFont(ofSize: 10))
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 6
        return stack
    }()

    let activity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        indicator.color = UIColor.white
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func update(album: Album) {
        imageView.image = nil
        nameLabel.text = nil
        genreLabel.text = nil

        nameLabel.text = album.collectionName
        genreLabel.text = album.primaryGenreName

        activity.startAnimating()

        CacheManager.sharedManager.checkImageCache(url: album.artworkUrl100) { (image) in
            self.imageView.image = image
            self.activity.stopAnimating()
        }
    }

    // MARK: - Private functions
    private func setup() {
        imageView.addSubview(activity)

        let activityCenterY = NSLayoutConstraint(item: activity, att: .centerY, toItem: imageView, const: 0)
        let activityCenterX = NSLayoutConstraint(item: activity, att: .centerX, toItem: imageView, const: 0)

        imageView.addConstraints([activityCenterX, activityCenterY])

        verticalStack.addArrangedSubview(imageView)
        verticalStack.addArrangedSubview(nameLabel)
        verticalStack.addArrangedSubview(genreLabel)
        addSubview(verticalStack)

        let top = NSLayoutConstraint(item: verticalStack, att: .top, toItem: self, const: 0)
        let left = NSLayoutConstraint(item: verticalStack, att: .leading, toItem: self, const: 0)

        addConstraints([top, left])

        self.backgroundColor = UIColor.white
    }
}

extension SearchrResultCell: ReuseIdentifierProtocol {

}
