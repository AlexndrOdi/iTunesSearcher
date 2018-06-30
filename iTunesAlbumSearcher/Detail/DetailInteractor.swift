//
//  DetailInteractor.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol DetailInteractorInputProtocol: class {
    func fetchTracksBy(collectionId: Int?)
}

protocol DetailInteractoroutputProtocol: class {
    func providedTracks(_ tracks: [Track])
    func providedError(_ error: Error)
}

class DetailInteractor: DetailInteractorInputProtocol {

    // MARK: - Properties
    weak var presenter: DetailInteractoroutputProtocol?

    var tracks: [Track] = []

    // MARK: - Functions
    func fetchTracksBy(collectionId: Int?) {
        if let this = collectionId {
            APIManager.sharedManager.request(this.description,
                                             APIManager.API.tracks,
                                             type: Track.self) { (tracks, error) in
                if let err = error {
                    self.presenter?.providedError(err)
                }
                self.tracks = tracks
                DispatchQueue.main.async {
                    self.provideTracks()
                }
            }
        }
    }

    // MARK: - Private functions
    private func provideTracks() {
        presenter?.providedTracks(self.tracks)
    }
}
