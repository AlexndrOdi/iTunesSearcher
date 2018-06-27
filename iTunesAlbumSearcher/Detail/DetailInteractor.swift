//
//  DetailInteractor.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

protocol DetailInteractorInputProtocol: class {
    
}

protocol DetailInteractoroutputProtocol: class {
    
}

class DetailInteractor: DetailInteractorInputProtocol {
    
    weak var presenter: DetailInteractoroutputProtocol?
}
