//
//  CacheManager.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 29.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

class CacheManager {
    // MARK: - Properties
    static let sharedManager = CacheManager()

    var imageCache: NSCache<NSString, UIImage>

    // MARK: - Init
    init() {
        self.imageCache = NSCache()
    }

    // MARK: - Functions
    ///Provide cached images or load data image if needed
    func checkImageCache(url: String, complition: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            print("Image url not found.")
            complition(nil)
            return
        }
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            complition(cachedImage)
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    guard let image = UIImage(data: data) else { return }
                    self.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                    complition(image)
                }
            }
        }
    }

    ///Clear all cached objects
    func clearAllCache() {
        imageCache.removeAllObjects()
    }
}
