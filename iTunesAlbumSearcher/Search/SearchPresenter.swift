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
    
    weak var view: SearchViewControllerInputProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    
    //MARK: - Navigation
    func navigateToAlbumDetail() {
        router?.navigateToAlbum()
    }
    
    //MARK: - Pass data by identifier
    func passDataToNextScene(segue: UIStoryboardSegue) {
        
    }
    
    
    //SearchBar
}
