//
//  SearchInteractor.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 26.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol SearchInteractorInputProtocol: class {
    func fetchAlbumsBy(searchString: String)
    func cancelFetchingAlbums()
    func clearCache()
}

protocol SearchInteractorOuputProtocol: class {
    func provideAlbums(_ albums: [Album])
    func provideError(error: Error)
}

class SearchInteractor: SearchInteractorInputProtocol {

    // MARK: - Properties
    weak var presenter: SearchPresenterInputProtocol?

    var albums: [Album] = []

    // MARK: - Functions
    func fetchAlbumsBy(searchString: String) {
        APIManager.sharedManager.request(searchString, APIManager.API.albums, type: Album.self) { (albums, error) in
            if let err = error {
                self.presenter?.provideError(error: err)
                return
            }
            self.albums = albums.sorted(by: { $1.collectionName > $0.collectionName })
            DispatchQueue.main.async {
                self.updateAlbums()
            }
        }
    }
    func cancelFetchingAlbums() {
        APIManager.sharedManager.stopRequest()
    }
    func clearCache() {
        CacheManager.sharedManager.clearAllCache()
    }

    // MARK: - Private functions
    private func updateAlbums() {
        presenter?.provideAlbums(self.albums)
    }
}
