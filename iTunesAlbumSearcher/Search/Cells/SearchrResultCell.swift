//
//  SearchrResultCell.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 26.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class SearchrResultCell: UICollectionViewCell {
    
    //Views
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 90).isActive = true
        image.heightAnchor.constraint(equalToConstant: 90).isActive = true
        image.backgroundColor = UIColor.red
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 12))
        label.lineBreakMode = .byTruncatingTail
        label.backgroundColor = UIColor.purple
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel(UIFont.systemFont(ofSize: 10))
        label.lineBreakMode = .byTruncatingTail
        label.backgroundColor = UIColor.lightGray
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Setup views in cell
    private func setup() {
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
