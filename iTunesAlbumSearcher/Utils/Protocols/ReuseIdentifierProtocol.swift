//
//  ReuseIdentifierProtocol.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 26.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

public protocol ReuseIdentifierProtocol {
    static var identifier: String { get }
}

extension ReuseIdentifierProtocol where Self: UIView {
    ///Return class name in string representaion
    static var identifier: String {
        guard let reuseId = NSStringFromClass(self).components(separatedBy: ".").last else {
            fatalError("Incorrect name of collection view cell.")
        }
        return reuseId
    }
}
