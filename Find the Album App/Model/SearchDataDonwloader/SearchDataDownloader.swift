import Foundation

final class SearchDataDownloader {

    /// Data downloader obtained from album searches.
    /// After downloading, the array contains objects with parameters such as collectionId (album id),
    /// artworkUrl100 (album cover link), collectionName (album title).
    /// - Parameters:
    ///   - url: Link to get the albums the user is looking for.
    ///   - completionHandler: The first parameter is an array of albums
    ///   retrieved at the user's request. The second parameter is an error handling enum.
    func downloadSearchData(fromURL url: String, completionHandler: @escaping (Result <[AlbumSearchData],
                                                                               ErrorHandling>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.iTunesUrlIsEmpty))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return completionHandler(.failure(.dataIsIncorrect)) }

            let albums = SearchDataDecoder().decodeSearchData(from: data)
            DispatchQueue.main.async {
                completionHandler(.success(albums.results))
            }
        }
        task.resume()
    }
}
