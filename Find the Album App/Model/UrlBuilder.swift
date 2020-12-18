import Foundation

final class UrlBuilder {

    /// The function creates a URL from their constituent parts. For example:
    /// https://itunes.appl.com/search?term=Toxicity&entity=album&attribute=albumTerm&limit=3
    /// scheme - https
    /// host - itunes.appl.com
    /// path - /search
    /// key - term
    /// albumName - Toxicity
    /// entity - album
    /// attribute - albumTerm
    /// - Parameters:
    ///   - albumName: Album name. For example: Toxicity.
    ///   - entity: The type of results you want returned, relative to the specified media type.
    ///   For example: movieArtist for a movie media type search.
    ///   - path: Resource address on the web server.
    ///   - key: The URL-encoded text string you want to search for. For example: jack+johnson.
    /// - Returns: Returns a URL from its constituent parts. Returned value type URLComponents.
    func withComponent(search albumName: String, entity: String, path: String, key: String) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "itunes.apple.com"
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: key, value: albumName),
            URLQueryItem(name: "entity", value: entity),
            URLQueryItem(name: "attribute", value: "albumTerm")
        ]
        return urlComponents
    }
}
