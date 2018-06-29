//
//  DetailTableViewController.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol DetailTableViewControllerInputProtocol: class {
    func displayTracks(_ tracks: [Track])
    func showActivity()
    func hideActivity()
}

protocol DetailTableViewControllerOutputProtocol: class {
    func performTracks(_ collectionId: Int?)
}

class DetailTableViewController: UITableViewController, DetailTableViewControllerInputProtocol {

    //MARK: - Properties
    var presenter: DetailTableViewControllerOutputProtocol?

    var album: Album?
    var tracks: [Track] = []

    //MARK: - Activity indicator
    let activity: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .whiteLarge
        indicator.color = UIColor.black
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailConfigurer.sharedInstance.configure(view: self)

        tableView.register(ProfileCell.self, forHeaderFooterViewReuseIdentifier: ProfileCell.identifier)
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
        presenter?.performTracks(album?.collectionId)
        self.view.addSubview(activity)
    }
    
    //MARK: - TableView functions
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileCell.identifier) as? ProfileCell else {
            fatalError("The dequeued cell is not an instance of ProfileCell")
        }
        cell.update(album: album)
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 0 : 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier, for: indexPath) as? SongCell else {
            fatalError("The dequeued cell is not an instance of SongCell")
        }
        cell.update(track: tracks[indexPath.row])
        
        return cell
    }
    
    //MARK: - Functions
    func displayTracks(_ tracks: [Track]) {
        self.tracks = tracks
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }    
}
extension DetailTableViewController {
    
    //MARK: - Activity indicator
    func showActivity() {
        if activity.isAnimating { return }
        activity.center = self.tableView.center
        activity.startAnimating()
    }
    
    func hideActivity() {
        if !activity.isAnimating { return }
        activity.stopAnimating()
    }
}
