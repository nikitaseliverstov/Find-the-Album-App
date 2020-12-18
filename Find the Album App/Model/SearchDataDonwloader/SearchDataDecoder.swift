import Foundation

final class SearchDataDecoder {

    /// Decoding the data of those albums that the user was looking for.
    /// - Parameter data: Albums data.
    /// - Returns: Returns decoded albums data.
    func decodeSearchData(from data: Data) -> AlbumsSearchData {
        let decoder = JSONDecoder()
        return (try? decoder.decode(AlbumsSearchData.self, from: data)) ?? AlbumsSearchData(results: [])
    }
}
