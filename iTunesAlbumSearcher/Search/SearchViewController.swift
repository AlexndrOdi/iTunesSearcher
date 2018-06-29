//
//  SearchViewController.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 26.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol SearchViewControllerInputProtocol: class {
    func displaySearchResult(albums: [Album])
    func showActivity()
    func hideActivity()
}

protocol SearchViewControllerOutputProtocol: class {
    func navigateToAlbumDetail()
}

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    var presenter: SearchPresenterInputProtocol?

    var albums: [Album] = []

    // MARK: - Activity view
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black
        indicator.hidesWhenStopped = true
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        SearchConfigurer.sharedInstance.configure(view: self)

        collectionView?.register(SearchrResultCell.self,
                                 forCellWithReuseIdentifier: SearchrResultCell.identifier)
        collectionView?.register(HeaderWithSearchBarCell.self,
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                 withReuseIdentifier: HeaderWithSearchBarCell.identifier)
        collectionView?.backgroundColor = UIColor.white
        self.navigationItem.title = Consts.NavigationTitle.searchView.rawValue
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 232/255,
                                                                           green: 140/255,
                                                                           blue: 1, alpha: 1)
        self.view.addSubview(activityIndicator)
    }

    // MARK: - Functions
    func displaySearchResult(albums: [Album]) {
        self.albums = albums
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }

    // MARK: - Collection view layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width / 3) - 16, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60)
    }

    // MARK: - Collection view data source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell  = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                         withReuseIdentifier: HeaderWithSearchBarCell.identifier,
                                         for: indexPath) as? HeaderWithSearchBarCell else {
            fatalError("The dequeued cell is not an instance of SearchrResultCell")
        }
        cell.searchbar.delegate = presenter

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchrResultCell.identifier,
                                                            for: indexPath) as? SearchrResultCell else {
            fatalError("The dequeued cell is not an instance of SearchrResultCell")
        }
        cell.update(album: albums[indexPath.row])

        return cell
    }

    // MARK: - Collection view delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.navigateToAlbumDetail()
    }

}
// MARK: - Activity indicator + InputProtocol
extension SearchViewController: SearchViewControllerInputProtocol {

    func showActivity() {
        if activityIndicator.isAnimating { return }
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    func hideActivity() {
        if !activityIndicator.isAnimating { return }
        activityIndicator.stopAnimating()
    }
}
