import UIKit

final class AlbumDataDownloader {

    /// Album data downloader . After downloading, the array contains objects with
    /// such parameters as primaryGenreName (album genre), artworkUrl100 (album cover link),
    /// collectionName (album title), trackName (track name).
    /// - Parameters:
    ///   - url: Link of the selected album.
    ///   - completionHandler: The first parameter is the album data array.
    ///   The second parameter is an enumeration for handling errors.
    func downloadAlbumData(fromURL url: String, completionHandler: @escaping (Result <[AlbumData],
                                                                               ErrorHandling>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.iTunesUrlIsEmpty))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return completionHandler(.failure(.dataIsIncorrect)) }
            let albums = AlbumDateDecoder().decodeAlbumData(from: data)
            DispatchQueue.main.async {
                completionHandler(.success(albums.results))
            }
        }
        task.resume()
    }
}
