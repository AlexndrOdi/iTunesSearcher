//
//  NSLayoutConstraint + ().swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    convenience init(item: UIView, att: NSLayoutAttribute, toItem: UIView, const: CGFloat) {
        self.init(item: item, attribute: att, relatedBy: .equal, toItem: toItem, attribute: att, multiplier: 1, constant: const)
    }
    
}
