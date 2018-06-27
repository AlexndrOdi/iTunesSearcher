//
//  DetailTableViewController.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import UIKit

protocol DetailTableViewControllerInputProtocol: class {
    
}

protocol DetailTableViewControllerOutputProtocol: class {
    
}

class DetailTableViewController: UITableViewController, DetailTableViewControllerInputProtocol {
    
    var presenter: DetailTableViewControllerOutputProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        DetailConfigurer.sharedInstance.configure(view: self)
        
        tableView.register(ProfileCell.self, forHeaderFooterViewReuseIdentifier: ProfileCell.identifier)
        tableView.register(SongCell.self, forCellReuseIdentifier: SongCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileCell.identifier) as? ProfileCell else {
            fatalError("The dequeued cell is not an instance of ProfileCell")
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.identifier, for: indexPath) as? SongCell else {
            fatalError("The dequeued cell is not an instance of SongCell")
        }
        
        return cell
    }

}
