//
//  Album.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

struct Album: Codable {
    var artistName: String
    var artworkUrl100: String
    var collectionId: Int
    var collectionName: String
    var country: String
    var primaryGenreName: String
    var releaseDate: String
}
