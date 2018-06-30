//
//  DetailPresenter.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol DetailPresenterProtocol: DetailInteractoroutputProtocol, DetailTableViewControllerOutputProtocol {

}

class DetailPresenter: DetailPresenterProtocol {

    // MARK: - Properties
    weak var view: DetailTableViewControllerInputProtocol?
    var interactor: DetailInteractorInputProtocol?

    // MARK: - Functions
    func performTracks(_ collectionId: Int?) {
        view?.showActivity()
        interactor?.fetchTracksBy(collectionId: collectionId)
    }

    func providedTracks(_ tracks: [Track]) {
        view?.hideActivity()
        view?.displayTracks(tracks)
    }
    func providedError(_ error: Error) {
        view?.hideActivity()
        view?.showAlertWith(description: error.localizedDescription)
    }
}
