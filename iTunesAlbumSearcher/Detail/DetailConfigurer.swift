//
//  DetailConfigurer.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class DetailConfigurer {

    // MARK: - Properties
    static let sharedInstance = DetailConfigurer()

    // MARK: - Functions
    func configure(view: DetailTableViewController) {
        let presenter = DetailPresenter()
        let interactor = DetailInteractor()

        view.presenter = presenter

        presenter.view = view
        presenter.interactor = interactor

        interactor.presenter = presenter
    }
}
