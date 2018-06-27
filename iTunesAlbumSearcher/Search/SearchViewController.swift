//
//  SearchViewController.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 26.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol SearchViewControllerInputProtocol: class {
    
}

protocol SearchViewControllerOutputProtocol: class {
    func navigateToAlbumDetail()
    func passDataToNextScene(segue: UIStoryboardSegue)
}

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, SearchViewControllerInputProtocol {
    
    var presenter: SearchPresenterInputProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        APIManager.sharedManager.request("park", APIManager.API.albums, type: Album.self) { (albums) in
            albums.forEach({ (item) in
                print(item)
            })
        }
        
        
        
        
        
        SearchConfigurer.sharedInstance.configure(view: self)
        
        collectionView?.register(SearchrResultCell.self,
                                 forCellWithReuseIdentifier: SearchrResultCell.identifier)
        collectionView?.register(HeaderWithSearchBarCell.self,
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                 withReuseIdentifier: HeaderWithSearchBarCell.identifier)
        collectionView?.backgroundColor = UIColor.white
    }

    //MARK: - Collection view layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width / 3) - 16, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60)
    }
    
    //MARK: - Collection view data source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell  = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                          withReuseIdentifier: HeaderWithSearchBarCell.identifier, for: indexPath) as? HeaderWithSearchBarCell else {
            fatalError("The dequeued cell is not an instance of SearchrResultCell")
        }
        
        cell.searchbar.delegate = presenter
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchrResultCell.identifier, for: indexPath) as? SearchrResultCell else {
            fatalError("The dequeued cell is not an instance of SearchrResultCell")
        }

        cell.nameLabel.text = "Some album name"
        cell.genreLabel.text = "Some genre"
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    //MARK: - Collection view delegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.navigateToAlbumDetail()
    }
   
}
