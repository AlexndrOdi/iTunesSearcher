//
//  UILabel + defaultInit.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(_ font: UIFont ) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        self.font = font
    }
    
    convenience init(_ font: UIFont, _ heightAnchorConstraint: CGFloat) {
        self.init(font)
        self.heightAnchor.constraint(equalToConstant: heightAnchorConstraint)
    }
}
