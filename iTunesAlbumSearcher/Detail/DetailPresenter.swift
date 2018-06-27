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
    
    weak var view: DetailTableViewControllerInputProtocol?
    var interactor: DetailInteractorInputProtocol?
}
