//
//  ProfileCell.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewHeaderFooterView {

    //MARK: - Views
    let imageAlbum: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return view
    }()

    let album: UILabel = {
        let label = UILabel(UIFont.systemFont(ofSize: 10), 16)
        label.backgroundColor = UIColor.blue
        return label
    }()
    let artist: UILabel = {
        let label = UILabel(UIFont.systemFont(ofSize: 10), 16)
        label.backgroundColor = UIColor.yellow
        return label
    }()
    let genre: UILabel = {
        let label = UILabel(UIFont.systemFont(ofSize: 10), 16)
        label.backgroundColor = UIColor.cyan
        return label
    }()
    let country: UILabel = {
        let label = UILabel(UIFont.systemFont(ofSize: 10), 16)
        label.backgroundColor = UIColor.brown
        return label
    }()
    let year: UILabel = {
        let label = UILabel(UIFont.systemFont(ofSize: 10), 16)
        label.backgroundColor = UIColor.green
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
    
    private func setup() {
        verticalStack.addArrangedSubview(album)
        verticalStack.addArrangedSubview(artist)
        verticalStack.addArrangedSubview(genre)
        verticalStack.addArrangedSubview(country)
        verticalStack.addArrangedSubview(year)

        addSubview(imageAlbum)
        addSubview(verticalStack)

        verticalStack.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let imageLeft = NSLayoutConstraint(item: imageAlbum, att: .leading, toItem: self, const: 4)
        let imageCenterY = NSLayoutConstraint(item: imageAlbum, att: .centerY, toItem: self, const: 0)
        
        let stackLeft = NSLayoutConstraint(item: verticalStack, attribute: .leading, relatedBy: .equal, toItem: imageAlbum, attribute: .trailing, multiplier: 1, constant: 8)
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
