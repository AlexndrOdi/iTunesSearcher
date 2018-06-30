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
    func displayEmptyField(show: Bool)
    func showActivity()
    func hideActivity()
    func showAlertWith(description: String?)
}

protocol SearchViewControllerOutputProtocol: class {
    func navigateToAlbumDetail()
}

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Properties
    var presenter: SearchPresenterInputProtocol?

    var albums: [Album] = []
    var emptyReslut: Bool = false

    // MARK: - Activity view
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black
        indicator.hidesWhenStopped = true
        return indicator
    }()
    // MARK: - Alert view
    let alert: UIAlertController = {
        let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        SearchConfigurer.sharedInstance.configure(view: self)

        collectionView?.register(SearchrResultCell.self,
                                 forCellWithReuseIdentifier: SearchrResultCell.identifier)
        collectionView?.register(HeaderWithSearchBarCell.self,
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                 withReuseIdentifier: HeaderWithSearchBarCell.identifier)
        collectionView?.register(NotFoundCell.self,
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionFooter,
                                 withReuseIdentifier: NotFoundCell.identifier)
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
    func displayEmptyField(show: Bool) {
        emptyReslut = show
        self.albums = []
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    func showAlertWith(description: String?) {
        if description != nil {
            self.alert.message = description
        } else {
            self.alert.message = RequestError().otherError
        }
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Collection view layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width / 3) - 16, height: 130)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height/2)
    }

    // MARK: - Collection view data source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                            withReuseIdentifier: HeaderWithSearchBarCell.identifier,
                                            for: indexPath) as? HeaderWithSearchBarCell else {
                fatalError("The dequeued cell is not an instance of SearchrResultCell")
            }
            cell.searchbar.delegate = presenter

            return cell
        }
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter,
                                                                         withReuseIdentifier: NotFoundCell.identifier,
                                                                         for: indexPath) as? NotFoundCell else {
                fatalError("The dequeued cell is not an instance of NotFoundCell")
        }
        cell.update(empty: emptyReslut)
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
