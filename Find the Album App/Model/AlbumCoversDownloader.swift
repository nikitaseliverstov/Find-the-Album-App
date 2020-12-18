import Foundation

final class AlbumCoversDownloader {

    /// Album cover data downloader.
    /// - Parameters:
    ///   - url: Album cover link.
    ///   - completionHandler: The first parameter is the cover data.
    ///   The second parameter is an enumeration for handling errors.
    func getCoverData(fromURL url: URL, completionHandler: @escaping (Result <Data,
                                                                              ErrorHandling>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
            } else {
                completionHandler(.failure(.dataIsIncorrect))
            }
        }
        task.resume()
    }
}
