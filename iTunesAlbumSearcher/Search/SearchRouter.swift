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
}

class SearchRouter: SearchRouterProtocol {

    // MARK: - Properties
    weak var view: SearchViewController?

    // MARK: - Navigations
    func navigateToAlbum() {
        let viewController = DetailTableViewController()
        passDataToNextScene(destinationVC: viewController)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Data pass function
    private func passDataToNextScene(destinationVC: DetailTableViewController) {
        guard let selectedIndexPath = self.view?.collectionView?.indexPathsForSelectedItems?.first else {
            fatalError("The selected item is not being displayed by the table")
        }
        guard let album = view?.albums[selectedIndexPath.row] else {
            fatalError("Not found album in \(selectedIndexPath.row)")
        }
        destinationVC.album = album
    }
}
