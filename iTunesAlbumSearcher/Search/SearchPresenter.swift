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
        view?.displaySearchResult(albums: albums)
    }

    // MARK: - SearchBar methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view?.showActivity()
        interactor?.fetchAlbumsBy(searchString: self.searchText)
        searchBar.resignFirstResponder()
    }
}
