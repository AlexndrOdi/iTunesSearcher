//
//  SearchInteractor.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 26.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol SearchInteractorInputProtocol: class {
    
}

protocol SearchInteractorOuputProtocol: class {
    
}

class SearchInteractor: SearchInteractorInputProtocol {
    
    weak var presenter: SearchPresenterInputProtocol?
    
}
