//
//  ProfileCell.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewHeaderFooterView {

    // MARK: - Views
    let imageAlbum: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()

    let albumText: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 12), 16)
        label.textColor = UIColor.blue
        return label
    }()
    let artistText: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 12), 16)
        label.textColor = UIColor.blue
        return label
    }()
    let genreText: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 12), 16)
        label.textColor = UIColor.blue
        return label
    }()
    let countryText: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 12), 16)
        label.textColor = UIColor.blue
        return label
    }()
    let yearText: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 12), 16)
        label.textColor = UIColor.blue
        return label
    }()

    let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        stack.backgroundColor = UIColor.white
        return stack
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    func update(album: Album?) {
        guard let recivedAlbum = album else { return }

        self.albumText.text = "Album: " + recivedAlbum.collectionName
        self.artistText.text = "Artist: " + recivedAlbum.artistName
        self.genreText.text = "Genre: " + recivedAlbum.primaryGenreName
        self.countryText.text = "Country: " + recivedAlbum.country
        self.yearText.text = "Date: " + recivedAlbum.releaseDate.prefix(10)

        CacheManager.sharedManager.checkImageCache(url: recivedAlbum.artworkUrl100) { (image) in
            self.imageAlbum.image = image
        }
    }

    // MARK: - Private functions
    private func setup() {
        verticalStack.addArrangedSubview(albumText)
        verticalStack.addArrangedSubview(artistText)
        verticalStack.addArrangedSubview(genreText)
        verticalStack.addArrangedSubview(countryText)
        verticalStack.addArrangedSubview(yearText)

        addSubview(imageAlbum)
        addSubview(verticalStack)

        verticalStack.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let imageLeft = NSLayoutConstraint(item: imageAlbum, att: .leading, toItem: self, const: 4)
        let imageCenterY = NSLayoutConstraint(item: imageAlbum, att: .centerY, toItem: self, const: 0)

        let stackLeft = NSLayoutConstraint(item: verticalStack, attribute: .leading, relatedBy: .equal,
                                           toItem: imageAlbum, attribute: .trailing, multiplier: 1, constant: 8)
        let stackCenterY = NSLayoutConstraint(item: verticalStack, att: .centerY, toItem: self, const: 0)
        let stackRight = NSLayoutConstraint(item: verticalStack, att: .trailing, toItem: self, const: -8)

        addConstraints([imageLeft, imageCenterY,
                        stackLeft, stackRight, stackCenterY])

        isUserInteractionEnabled = false

        backgroundView = {
            let view = UIView()
            view.backgroundColor =  UIColor.white
            return view
        }()
    }
}

extension ProfileCell: ReuseIdentifierProtocol {

}
