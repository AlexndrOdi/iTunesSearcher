//
//  SearchRouter.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 26.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol SearchRouterProtocol: class {
    func navigateToAlbum()
    func passDataToNextScene(segue: UIStoryboardSegue)
}

class SearchRouter: SearchRouterProtocol {
    
    weak var view: SearchViewController?
    
    func navigateToAlbum() {
        let vc = DetailTableViewController()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func passDataToNextScene(segue: UIStoryboardSegue) {
        //TODO: ..
    }
}
