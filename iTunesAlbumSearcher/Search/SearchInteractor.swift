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
}

protocol SearchInteractorOuputProtocol: class {
    func provideAlbums(_ albums: [Album])
}

class SearchInteractor: SearchInteractorInputProtocol {
    
    //MARK: - Properties
    weak var presenter: SearchPresenterInputProtocol?
    
    var albums: [Album] = []
    
    //MARK: - Functions
    func fetchAlbumsBy(searchString: String) {
        APIManager.sharedManager.request(searchString, APIManager.API.albums, type: Album.self) { (albums) in
            self.albums = albums.sorted(by: { $1.collectionName > $0.collectionName })
            DispatchQueue.main.async {
                self.updateAlbums()
            }
        }
    }
    
    //MARK: - Private functions
    private func updateAlbums() {
        presenter?.provideAlbums(self.albums)
    }
}
