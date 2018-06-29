//
//  JSONDecoder + decodeByPath.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 28.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(type: T.Type, from data: Data, byKey path: String) throws -> T {
        let jsonTop = try JSONSerialization.jsonObject(with: data)
        guard let jsonChild = (jsonTop as AnyObject).value(forKeyPath: path) else {
            throw DecodingError.valueNotFound(T.self, DecodingError.Context.init(codingPath: [], debugDescription: "Child value \(path) not found."))
        }
        let resultData = try JSONSerialization.data(withJSONObject: jsonChild)
        return try decode(type, from: resultData)
    }
}
