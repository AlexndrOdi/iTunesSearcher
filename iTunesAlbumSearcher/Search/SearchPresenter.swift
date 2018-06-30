//
//  SearchPresenter.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 26.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol SearchPresenterInputProtocol: SearchViewControllerOutputProtocol, SearchInteractorOuputProtocol, UISearchBarDelegate {

}

class SearchPresenter: NSObject, SearchPresenterInputProtocol {

    // MARK: - Properties
    weak var view: SearchViewControllerInputProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?

    var searchText: String = ""

    // MARK: - Navigation
    func navigateToAlbumDetail() {
        router?.navigateToAlbum()
    }

    // MARK: - Functions
    func provideAlbums(_ albums: [Album]) {
        view?.hideActivity()
        if albums.isEmpty {
            view?.displayEmptyField(show: true)
        } else {
            view?.displaySearchResult(albums: albums)
        }
    }
    func provideError(error: Error) {
        view?.hideActivity()
        view?.showAlertWith(description: error.localizedDescription)
    }

    // MARK: - SearchBar functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view?.displayEmptyField(show: false)
        view?.showActivity()
        interactor?.clearCache()
        interactor?.fetchAlbumsBy(searchString: self.searchText)
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        interactor?.cancelFetchingAlbums()
        view?.displayEmptyField(show: false)
        view?.hideActivity()
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = nil
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
}
