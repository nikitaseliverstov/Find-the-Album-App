//
//  SearchDataDownloader.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 14.12.2020.
//

import UIKit

final class SearchDataDownloader {
    
    let soad = "https://itunes.apple.com/search?term=A&entity=album&attribute=albumTerm&limit=100"

    func downloadSearchData(url: String, completionHandler: @escaping ([AlbumSearchData]) -> Void) throws {
        guard let url = URL(string: url) else {
            throw Mistakes.iTunesUrlIsEmpty
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let albums = SearchDataDecoder().decodeSearchData(from: data)
            DispatchQueue.main.async {
                completionHandler(albums.results)
            }
        }
        task.resume()
    }
}
