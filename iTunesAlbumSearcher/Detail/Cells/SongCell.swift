//
//  SongCell.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    //MARK: - Views
    var trackNumber: UILabel = {
        let label = UILabel(UIFont.boldSystemFont(ofSize: 16))
        label.widthAnchor.constraint(equalToConstant: 40)
        label.textAlignment = .center
        return label
    }()
    
    var trackName: UILabel = {
        let label = UILabel(UIFont.systemFont(ofSize: 16))
        return label
    }()
    
    var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 30
        return stack
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    func update(track: Track) {
        trackNumber.text = track.trackNumber?.description
        trackName.text = track.trackName
    }
    
    //MARK: - Private functions
    private func setup() {
        horizontalStack.addArrangedSubview(trackNumber)
        horizontalStack.addArrangedSubview(trackName)
        
        addSubview(horizontalStack)
        
        let centerY = NSLayoutConstraint(item: horizontalStack, att: .centerY, toItem: self, const: 0)
        let left = NSLayoutConstraint(item: horizontalStack, att: .leading, toItem: self, const: 8)
        
        addConstraints([centerY, left])
        isUserInteractionEnabled = false
    }
}

extension SongCell: ReuseIdentifierProtocol {
    
}
