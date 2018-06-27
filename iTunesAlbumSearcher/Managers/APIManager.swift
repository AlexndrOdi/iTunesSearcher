//
//  APIManager.swift
//  iTunesAlbumSearcher
//
//  Created by Alex Odintsov on 27.06.2018.
//  Copyright © 2018 Alex Odintsov. All rights reserved.
//

import Foundation

class APIManager {
    
    enum API: String {
        case albums = "https://itunes.apple.com/search?entity=album&attribute=albumTerm&limit=2&term="
        case tracks = "https://itunes.apple.com/lookup?entity=song&id="
    }
    
    static let sharedManager = APIManager()
    
    //MARK: - Generic request for decode data in needable structure
    func request<T: Decodable>(_ searchString: String, _ requestURL: API , type: T.Type, complition: @escaping ([T])-> ()) {
        
        let formattedSearchString = searchString.replacingOccurrences(of: " ", with: "+")
        
        guard let searchURL = URL(string: requestURL.rawValue + formattedSearchString) else {
            print("Incorrect URL request")
            return
        }
        
        URLSession.shared.dataTask(with: searchURL) { (result, response, error) in
            if error != nil {
                print("Error: \(String(describing: error?.localizedDescription))")
                return
            }

            guard let data = result else { return }
            
            do {
                let models = try JSONDecoder().decode([T].self, from: data)
                complition(models)
            } catch let err {
                print("Decodable error: ", err.localizedDescription)
            }
        }.resume()
        
        return
    }
}
