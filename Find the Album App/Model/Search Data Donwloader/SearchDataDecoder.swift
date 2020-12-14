//
//  SearchDataDecoder.swift
//  Find the Album App
//
//  Created by Nikita Seliverstov on 14.12.2020.
//

import Foundation

final class SearchDataDecoder {
    func decodeSearchData(from data: Data) -> AlbumsSearchData {
        let decoder = JSONDecoder()
        return (try? decoder.decode(AlbumsSearchData.self, from: data)) ?? AlbumsSearchData(results: [])
    }
}
