import Foundation

final class AlbumDateDecoder {

    /// Decoding the data of the album that the user has selected.
    /// - Parameter data: Album data.
    /// - Returns: Returns decoded album data.
    func decodeAlbumData(from data: Data) -> AlbumsData {
        let decoder = JSONDecoder()
        return (try? decoder.decode(AlbumsData.self, from: data)) ?? AlbumsData(results: [])
    }
}
